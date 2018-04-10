class V1::BranchesController < ApplicationController
    before_action :authenticate_branch, except: [:index, :create]
    before_action :set_branch, only: [:show, :update, :destroy]

    def index
        @branches = Branch.all
        render json: {branches: @branches}
    end

    def create
        @branch = Branch.new(register_params)
        @branch.save!
        @branch.formatting_name
        json_response(@branch, :created)
    end

    def show
        json_response(@branch)
    end

    def update
        @branch.update(branch_params)
        json_response(@branch)
    end

    def destroy
        @branch.destroy
        head 204
    end

    private

    def set_branch
        @branch = current_branch
    end

    def register_params
        params.require(:branch).permit(:name, :phone_number, :password, :password_confirmation)
    end

    def branch_params
        params.require(:branch).permit(:name, :phone_number, :password, :password_confirmation,  
        :provinsi, :kabupaten, :kecamatan, :kelurahan, :address, :profile_picture)
    end
end