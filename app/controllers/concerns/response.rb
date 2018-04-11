module Response
    def json_response (object, status = :ok)
        render json: object, status: status
    end

    def json_error (object)
        render json: { errors: object.errors }, status: :unprocessable_entity
    end
end