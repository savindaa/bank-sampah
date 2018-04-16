class V1::BranchesController < ApplicationController
    before_action :authenticate_branch, except: [:index, :create, :blocking]
    before_action :authenticate_admin, only: [:blocking]
    before_action :set_branch, except: [:index, :create, :blocking]
    before_action :authenticate_customer, only: :index

    def index
        @branches = Branch.all.order(created_at: :desc)
        render json: {branches: @branches.as_json(only: [:id, :name, :address])}
    end

    def create
        @branch = Branch.new(register_params)
        @branch.password_confirmation = @branch.password
        @branch.save!
        @branch.formatting_name
        json_true(:created)
    end

    def show
        json_response(@branch)
    end

    def show_balance
        render json: @branch.as_json(only: [:phone_number, :balance])
    end

    def branch_show_deposit
        @acct_transactions = @branch.acct_transactions.where(status: "2", transaction_type_id: "1").newest
        render json: { transaction: @acct_transactions.as_json(only: [:id, :tr_id, :amount, :updated_at]) }
    end

    def branch_show_withdraw
        @acct_transactions = @branch.acct_transactions.where(status: "2", transaction_type_id: "2").newest
        render json: { transaction: @acct_transactions.as_json(only: [:id, :tr_id, :amount, :updated_at]) }
    end

    def update
        @branch.update(branch_params)
        json_true
    end

    def destroy
        @branch.destroy
        head 204
    end

    def blocking
        @branch = Branch.find_by(phone_number: params[:phone_number])
        if !@branch.nil?
            @branch.update(block_params)
            json_response_post(@branch)
        else
            render json: { result: false, message: 'Bank tidak terdaftar' }
        end
    end

    private

    def set_branch
        @branch = current_branch
    end

    def register_params
        params.require(:branch).permit(:name, :phone_number, :address, :password)
    end

    def branch_params
        params.require(:branch).permit(:name, :phone_number, :password, :password_confirmation,  
        :provinsi, :kabupaten, :kecamatan, :kelurahan, :address, :profile_picture)
    end

    def block_params
        params.require(:branch).permit(:blocked)
    end
end