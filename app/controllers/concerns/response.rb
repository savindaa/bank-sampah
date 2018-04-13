module Response
    def json_response (object, status = :ok)
        render json: object, status: status
    end

    def json_error (object)
        render json: { result: false, 
                       errors: object.errors }, status: :unprocessable_entity
    end

    def json_response_post (object)
        render json: { result: true, object: object }, status: :created
    end

    def json_true (status = :ok)
        render json: { result: true }, status: status
    end
end