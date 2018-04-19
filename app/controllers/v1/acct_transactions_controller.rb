class V1::AcctTransactionsController < ApplicationController
    before_action :authenticate_branch, only: [:deposit, :update, :branch_transaction_active, :branch_transaction_history]
    before_action :authenticate_customer, only: [:withdraw, :customer_transaction_active, :customer_transaction_history]
    before_action :set_branch, only: [:deposit, :update, :branch_transaction_active, :branch_transaction_history, :destroy]
    before_action :set_customer, only: [:withdraw, :customer_transaction_active, :customer_transaction_history]

    def show
        @acct_transaction = AcctTransaction.find(params[:id])
        json_response(@acct_transaction)
    end

    def show_by_tr
        @acct_transaction = AcctTransaction.find_by(tr_id: params[:tr_id])
        json_response(@acct_transaction)
    end

    def deposit
        @acct_transaction = @branch.acct_transactions.new(deposit_params)
        if !Customer.find_by(phone_number: @acct_transaction.customer_phone_number).nil?
            @acct_transaction.deposit_setting(@branch)
            @acct_transaction.save!
            if @acct_transaction.transaction_type_id == "1" && @acct_transaction.amount < Branch.find(@acct_transaction.branch_id).balance
                @acct_transaction.modify_acct_balance
                render json: { result: true, acct_transaction: @acct_transaction.as_json(except: [:point_received, :adjusted_bal],include: { trash_details: { only: [:item_name, :weight] } }) }
            else
                @acct_transaction.destroy
                render json: { result: false, acct_transaction: @acct_transaction.as_json(except: [:point_received, :adjusted_bal],include: { trash_details: { only: [:item_name, :weight] } }) }
            end
        else
            render json: { result: false, message: 'Nasabah tidak terdaftar' }
        end
    end

    def withdraw
        @acct_transaction = @customer.acct_transactions.new(withdraw_params)
        if !Branch.find(@acct_transaction.branch_id).nil?
            @acct_transaction.withdraw_setting(@customer)
            @acct_transaction.save!
            render json: { result: true, acct_transaction: @acct_transaction.as_json(only: [:id, :tr_id]) }
        else
            render json: { result: false, message: 'Bank tidak terdaftar' }
        end
    end

    # status 1 => "Menunggu konfirmasi"
    # status 2 => "Penarikan dana diterima"
    # status 3 => "Penarikan dana ditolak"

    def update
        @acct_transaction = @branch.acct_transactions.find(params[:id]) if @branch

        if @acct_transaction.status == "1"
            @acct_transaction.adjust_balance
            if @acct_transaction.update(approval_params) && @acct_transaction.status == "2"
                @acct_transaction.modify_acct_balance
                json_true
            elsif
                @acct_transaction.update(approval_params) && @acct_transaction.status == "3"
                json_true
            else
                @acct_transaction.update(status: "1")
                json_error(@acct_transaction)
            end
        else
            json_error(@acct_transaction)
        end
    end
    
    ## 4 method di bawah hanya menunjukkan withdraw
    def branch_transaction_active
        @acct_transactions = @branch.acct_transactions.active.newest
        render json: { transaction: @acct_transactions.as_json(except: [:point_received, :adjusted_bal],include: { customer: { only: :name } }) }
    end

    def branch_transaction_history
        @acct_transactions = @branch.acct_transactions.history.newest
        render json: { transaction: @acct_transactions.as_json(except: [:point_received, :adjusted_bal],include: { customer: { only: :name } }) }
    end

    # def customer_transaction_active
    #     @acct_transactions = @customer.acct_transactions.active.newest
    #     render json: { transaction: @acct_transactions.as_json(except: [:point_received, :adjusted_bal],include: { branch: { only: [:address, :phone_number] } }) }
    # end

    # def customer_transaction_history
    #     @acct_transactions = @customer.acct_transactions.history.newest
    #     render json: { transaction: @acct_transactions.as_json(except: [:point_received, :adjusted_bal],include: { branch: { only: [:address, :phone_number] } }) }    
    # end
    ##

    def destroy
        @acct_transaction = @branch.acct_transactions.find(params[:id]) if @branch
        if @acct_transaction.status == "1"
            @acct_transaction.destroy
            head 204
        else
            json_error(@acct_transaction) 
        end
    end

    private

    def set_branch
        @branch = current_branch
    end

    def set_customer
        @customer = current_customer
    end

    def deposit_params
        params.require(:acct_transaction).permit(:customer_phone_number, trash_details_attributes: [:item_name, :weight])
    end

    def withdraw_params
        params.require(:acct_transaction).permit(:amount, :branch_id)
    end

    def approval_params
        params.require(:acct_transaction).permit(:status, :comment)
    end
end