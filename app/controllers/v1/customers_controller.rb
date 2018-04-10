class V1::CustomersController < ApplicationController
    before_action :authenticate_customer, except: [:index, :create]
    before_action :set_customer, only: [:show, :update, :destroy]
    
    def index
        @customers = Customer.paginate(page: params[:page], per_page: 20).order(created_at: :desc)
        json_response(@customers)
    end

    def create
        @customer = Customer.create!(register_params)
        json_response(@customer, :created)
    end

    def show
        json_response(@customer)
    end

    def update
        @customer.update(customer_params)
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
        params.require(:customer).permit(:name, :phone_number, :password, :password_confirmation)
    end

    def customer_params
        params.require(:customer).permit(:name, :phone_number, :password, :password_confirmation, 
        :provinsi, :kabupaten, :kecamatan, :kelurahan, :address, :profile_picture)
    end
end