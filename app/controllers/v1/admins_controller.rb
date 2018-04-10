class V1:AdminsController < ApplicationController
    before_action :authenticate_admin, only: :destroy

    def create
        @admin = Admin.create!(admin_params)
        json_response(@admin, :create)
    end

    def destroy
        @admin = current_admin
        @admin.destroy
        head 204
    end

    private

    def admin_params
        params.require(:admin).permit(:email, :password, :password_confirmation)
    end
end