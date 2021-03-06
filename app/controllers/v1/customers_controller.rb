class V1::CustomersController < ApplicationController
    before_action :authenticate_customer, except: [:index, :create, :blocking]
    before_action :authenticate_admin, only: [:blocking, :index]
    before_action :set_customer, except: [:index, :create, :blocking]
    
    def index
        @customers = Customer.paginate(page: params[:page], per_page: 20).order(created_at: :desc)
        json_response(@customers)
    end

    def create
        @customer = Customer.new(register_params)
        @customer.password_confirmation = @customer.password
        @customer.save!
        @customer.formatting_name
        json_true(:created)
    end

    def show
        json_response(@customer)
    end

    def show_balance
        render json: @customer.as_json(only: [:phone_number, :balance])
    end

    def customer_show_deposit
        @acct_transactions = @customer.acct_transactions.where(status: "2", transaction_type_id: "1").newest
        render json: { transaction: @acct_transactions.as_json(only: [:id, :tr_id, :amount, :updated_at]) }
    end

    def customer_show_withdraw
        @acct_transactions = @customer.acct_transactions.where(status: "2", transaction_type_id: "2").newest
        render json: { transaction: @acct_transactions.as_json(only: [:id, :tr_id, :amount, :updated_at]) }
    end

    def customer_active_request
        @acct_transactions = @customer.acct_transactions.where(status: "1", transaction_type_id: "2")
        @pick_requests = @customer.pick_requests.where(status: ["1", "2"])
        @requests = (@acct_transactions | @pick_requests).sort_by {|h| h[:updated_at]}.reverse
        render json: { requests: @requests.as_json(only: [:status, :tr_id, :pr_id, :transaction_type_id], include: { branch: { only: [:id, :name, :address] } }) }, status: :ok
    end

    def customer_history_request
        @acct_transactions = @customer.acct_transactions.where(status: ["2", "3"], transaction_type_id: "2")
        @pick_requests = @customer.pick_requests.where(status: ["3", "4"])
        @requests = (@acct_transactions | @pick_requests).sort_by {|h| h[:updated_at]}.reverse
        render json: { requests: @requests.as_json(only: [:status, :tr_id, :pr_id, :transaction_type_id], include: { branch: { only: [:id, :name, :address] } }) }, status: :ok
    end

    def update
        @customer.update(customer_params)
        json_true
    end

    def blocking
        @customer = Customer.find_by(phone_number: params[:phone_number])
        if !@customer.nil?
            @customer.update(block_params)
            json_response_post(@customer)
        else
            render json: { result: false, message: 'Nasabah tidak terdaftar' }
        end
    end

    def destroy
        @customer.destroy
        head 204
    end

    private

    def set_customer
        @customer = current_customer
    end

    def register_params
        params.require(:customer).permit(:name, :phone_number, :password)
    end

    def customer_params
        params.require(:customer).permit(:name, :phone_number, :password, :password_confirmation, 
        :provinsi, :kabupaten, :kecamatan, :kelurahan, :address, :profile_picture)
    end

    def block_params
        params.require(:customer).permit(:blocked)
    end
end