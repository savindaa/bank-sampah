class V1::PickRequestsController < ApplicationController
    before_action :authenticate_branch, only: [:accept, :branch_active_pickrequest, :branch_history_pickrequest]
    before_action :authenticate_customer, only: [:create, :customer_active_pickrequest, :customer_history_pickrequest]
    before_action :set_branch, only: [:accept, :branch_active_pickrequest, :branch_history_pickrequest]
    before_action :set_customer, only: [:create, :customer_active_pickrequest, :customer_history_pickrequest]

    def show
        @pick_request = PickRequest.find(params[:id])
        json_response(@pick_request)
    end

    def show_by_pr
        @pick_request = PickRequest.find_by(pr_id: params[:pr_id])
        json_response(@pick_request)
    end

    def create
        @pick_request = @customer.pick_requests.new(request_params)
        @pick_request.request_setting(@customer)
        @pick_request.save!
        render json: { result: true, pick_request: @pick_request.as_json(only: [:id, :pr_id]) }
    end

    # status 1 => "Menunggu konfirmasi"
    # status 2 => "Sampah akan dijemput oleh Bank"
    # status 3 => "Sampah telah dijemput"
    # status 4 => "Permintaan ditolak"

    def accept
        @pick_request = @branch.pick_requests.find(params[:id]) if @branch

        if @pick_request.status == "1"
            if @pick_request.update(accept_params) && (@pick_request.status == "2" || @pick_request.status == "4")
                json_true
            else
                @pick_request.update(status: "1")
                json_error(@pick_request)
            end
        elsif @pick_request.status == "2"
            if @pick_request.update(accept_params) && (@pick_request.status == '3' || @pick_request.status =="4")
                json_true
            else
                @pick_request.update(status: "2")
                json_error(@pick_request)
            end
        else
            json_error(@pick_request)
        end
    end

    def customer_active_pickrequest
        @pick_request = @customer.pick_requests.active.newest
        render json: { pickrequest: @pick_request.as_json(except: [:customer_id, :branch_id]) }
    end

    def customer_history_pickrequest
        @pick_request = @customer.pick_requests.history.newest
        render json: { pickrequest: @pick_request.as_json(except: [:customer_id, :branch_id]) }
    end

    def branch_active_pickrequest
        @pick_request = @branch.pick_requests.active.newest
        render json: { pickrequest: @pick_request.as_json(except: [:customer_id, :branch_id], include: { customer:{ only: [:name, :phone_number] } }) }
    end

    def branch_history_pickrequest
        @pick_request = @branch.pick_requests.history.newest
        render json: { pickrequest: @pick_request.as_json(except: [:customer_id, :branch_id], include: { customer:{ only: [:name, :phone_number] } }) }
    end

    def destroy
        @branch = current_branch
        @pick_request = @branch.pick_requests.find(params[:id]) if @branch
        if @pick_request.status == '1' || @pick_request.status == '2' || @pick_request.status == '4'
            @pick_request.destroy
            head 204
        else
            json_error(@pick_request)
        end
    end

    private

    def set_branch
        @branch = current_branch
    end

    def set_customer
        @customer = current_customer
    end

    def request_params
        params.require(:pick_request).permit(:customer_address, :branch_id, trash_details_attributes: [:item_name, :weight])
    end

    def accept_params
        params.require(:pick_request).permit(:comment, :status)
    end

end