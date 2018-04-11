class V1::MyVouchersController < ApplicationController
    before_action :authenticate_customer
    before_action :set_customer

    def index
        @my_vouchers = @customer.my_vouchers.all 
        json_response(@my_vouchers.as_json(include: { voucher:{ only:[:name, :category, :description] } }))
    end

    def create
        @my_voucher = @customer.my_vouchers.new(my_voucher_params)
        @my_voucher.modify_customer_point
        @my_voucher.save!
        json_response(@my_voucher.as_json(include: { voucher:{ only:[:name, :category, :description] } }))
    end

    def show
        @my_voucher = @customer.my_vouchers.find(params[:id])
        json_response(@my_voucher)
    end

    def update
        @my_voucher = @customer.my_vouchers.find(params[:id])
        if @my_voucher.used == false
            if @my_voucher.update(params[:used]) && @my_voucher.used == true
                json_response(@my_voucher)
            else
                json_error(@my_voucher)
            end
        else
            json_error(@my_voucher)
        end
    end

    def destroy
        @my_voucher = @customer.my_vouchers.find(params[:id])
        @my_voucher.destroy
        head 204
    end

    private

    def set_customer
        @customer = current_customer
    end

    def my_voucher_params
        params.require(:my_voucher).permit(:voucher_id)
    end
end