class V1::TrashWeightsController < ApplicationController
    before_action :authenticate_branch, except: :show
    before_action :authenticate_customer, except: [:create, :show]
    before_action :set_need_detail
    before_action :set_trash_weight, only: [:show, :destroy]

    def create
        @trash_weight = @need_detail.create_trash_weight!(trash_params)
        @trash_weight.modify_transaction(@need_detail)
        json_response(@trash_weight, :created)
    end

    def show
        json_response(@trash_weight)
    end

    def destroy
        @trash_weight.destroy
        head 204
    end

    private

    def set_need_detail
        if params[:acct_transaction_id]
            @need_detail = AcctTransaction.find(params[:acct_transaction_id])
        elsif params[:pick_request_id]
            @need_detail = PickRequest.find(params[:pick_request_id])
        end
    end

    def set_trash_weight
        @trash_weight = @need_detail.trash_weight.find_by!(id: params[:id]) if @need_detail
    end

    def trash_params
        params.require(:trash_weight).permit(:plastik, :kertas, :botol, :besi, :other)
    end
end