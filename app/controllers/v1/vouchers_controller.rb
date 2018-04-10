class V1::VouchersController < ApplicationController
    before_action :authenticate_admin, except: :show

    def index
        @vouchers = Voucher.all 
        json_response(@vouchers)
    end

    def create
        @voucher = Voucher.create!(voucher_params)
        json_response(@voucher, :created)
    end

    def show
        @voucher = Voucher.find(params[:id])
        json_response(@voucher)
    end

    def update
        @voucher = Voucher.find(params[:id])
        @voucher.update(voucher_params)
        json_response(@voucher)
    end

    def destroy
        @voucher = Voucher.find(params[:id])
        @voucher.destroy
        head 204
    end

    private

    def voucher_params
        params.require(:voucher).permit(:name, :category, :point_needed, :description, :picture)
    end
end