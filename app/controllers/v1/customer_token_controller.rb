class V1::CustomerTokenController < Knock::AuthTokenController

    private

    def auth_params
        params.require(:auth).permit(:phone_number, :password)
    end

end
