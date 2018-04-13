class V1::AcctTransactionsController < ApplicationController
    # before_action :authenticate_branch, except: [:index, :show, :withdraw, :customer_transaction_history]
    # before_action :authenticate_customer, except: [:index, :show, :destroy, :deposit, :update, :branch_transaction_history]
    before_action :authenticate_branch, only: [:deposit, :update, :branch_transaction_active, :branch_transaction_history]
    before_action :authenticate_customer, only: [:withdraw, :customer_transaction_active, :customer_transaction_history]
    before_action :set_branch, only: [:deposit, :update, :branch_transaction_active, :branch_transaction_history, :destroy]
    before_action :set_customer, only: [:withdraw, :customer_transaction_active, :customer_transaction_history]

    def show
        @acct_transaction = AcctTransaction.find(params[:id])
        json_response(@acct_transaction)
    end

    def deposit
        @acct_transaction = @branch.acct_transactions.new(deposit_params)
        if !Customer.find_by(phone_number: @acct_transaction.customer_phone_number).nil?
            @acct_transaction.deposit_setting(@branch)
            @acct_transaction.save!
            render json: { result: true, acct_transaction: @acct_transaction.as_json(except: [:point_received, :adjusted_bal],include: { trash_weight: {only: [:plastik, :kertas, :botol, :besi, :other] } }) }
        else
            render json: { result: false, message: 'Nasabah tidak terdaftar' }
        end
    end

    def withdraw
        @acct_transaction = @customer.acct_transactions.new(withdraw_params)
        if !Branch.find_by(name: @acct_transaction.branch_name).nil?
            @acct_transaction.withdraw_setting(@customer)
            @acct_transaction.save!
            json_response_post(@acct_transaction)
        else
            render json: { result: false, message: 'Bank tidak terdaftar'}
        end
    end

    def update
        @acct_transaction = @branch.acct_transactions.find(params[:id]) if @branch

        if @acct_transaction.approved == false && @acct_transaction.showed == true
            @acct_transaction.adjust_balance
            if @acct_transaction.update(approval_params) && @acct_transaction.approved == true && @acct_transaction.showed == true
                @acct_transaction.modify_acct_balance
                json_true
            elsif
                @acct_transaction.update(approval_params) && @acct_transaction.approved == false && @acct_transaction.showed == false
                json_true
            else
                @acct_transaction.update(approved: false)
                @acct_transaction.update(showed: true)
                json_error(@acct_transaction)
            end
        else
            json_error(@acct_transaction)
        end
    end

    def branch_transaction_active
        @acct_transactions = @branch.acct_transactions.active.newest
        render json: {transaction: @acct_transactions}
    end

    def branch_transaction_history
        @acct_transactions = @branch.acct_transactions.history.newest
        render json: {transaction: @acct_transactions}
    end

    def customer_transaction_active
        @acct_transactions = @customer.acct_transactions.active.newest
        render json: {transaction: @acct_transactions}
    end

    def customer_transaction_history
        @acct_transactions = @customer.acct_transactions.history.newest
        render json: {transaction: @acct_transactions}    
    end

    def destroy
        @acct_transaction = @branch.acct_transactions.find(params[:id]) if @branch
        if @acct_transaction.approved == false
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
        params.require(:acct_transaction).permit(:customer_phone_number, trash_weight_attributes: [:plastik, :kertas, :botol, :besi, :other])
    end

    def withdraw_params
        params.require(:acct_transaction).permit(:amount, :branch_name)
    end

    def approval_params
        params.require(:acct_transaction).permit(:approved, :showed)
    end
end