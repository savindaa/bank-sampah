class V1::BranchTokenController < Knock::AuthTokenController

    private

    def auth_params
        params.require(:auth).permit(:phone_number, :password)
    end
end
