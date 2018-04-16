class V1::IndonesiaController < ApplicationController
    before_action :authenticate_customer

    def index_province
        @provinces = Province.all
        render json: { province: @provinces }, status: :ok
    end

    def index_regency
        @regencies = Regency.where(province_code: [34])
        render json: { regency: @regencies }, status: :ok
    end

    def index_district
        @districts = District.where(regency_code: params[:regency_code])
        render json: { district: @districts }, status: :ok
    end

    def index_village
        @villages = Village.where(district_code: params[:district_code])
        render json: { village: @villages }, status: :ok
    end

end