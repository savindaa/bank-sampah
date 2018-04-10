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
        @acct_transaction.deposit_setting(@branch)
        @acct_transaction.save!
        json_response(@acct_transaction, :created)
    end

    def withdraw
        @acct_transaction = @customer.acct_transactions.new(withdraw_params)
        @acct_transaction.withdraw_setting(@customer)
        @acct_transaction.save!
        json_response(@acct_transaction, :created)
    end

    def update
        @acct_transaction = @branch.acct_transactions.find_by(id: params[:id]) if @branch

        if @acct_transaction.approved == false
            @acct_transaction.adjust_balance
            if @acct_transaction.update(approval_params) && @acct_transaction.approved == true
                @acct_transaction.modify_acct_balance
                json_response(@acct_transaction)
            else
                render json: { errors: @acct_transaction.errors }, status: :unprocessable_entity
            end
        else
            render json: { errors: @acct_transaction.errors }, status: :unprocessable_entity
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
        @acct_transaction = @branch.acct_transactions.find_by(id: params[:id]) if @branch
        if @acct_transaction.approved == false
            @acct_transaction.destroy
            head 204
        else
            render json: { errors: @acct_transaction.errors }, status: :unprocessable_entity 
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
        params.require(:acct_transaction).permit(:customer_phone_number)
    end

    def withdraw_params
        params.require(:acct_transaction).permit(:amount, :branch_name)
    end

    def approval_params
        params.require(:acct_transaction).permit(:approved)
    end
end