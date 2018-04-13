class V1::CustomersController < ApplicationController
    before_action :authenticate_customer, except: [:index, :create, :blocking]
    # before_action :authenticate_admin, only: [:blocking, :index]
    before_action :set_customer, only: [:show, :update, :destroy]
    
    def index
        @customers = Customer.paginate(page: params[:page], per_page: 20).order(created_at: :desc)
        json_response(@customers)
    end

    def create
        @customer = Customer.new(register_params)
        @customer.password_confirmation = @customer.password
        @customer.save!
        json_true(:created)
    end

    def show
        json_response(@customer)
    end

    def update
        @customer.update(customer_params)
        json_true
    end

    def blocking
        @customer = Customer.find_by(phone_number: params[:phone_number])
        @customer.update(block_params)
        json_response(@customer)
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