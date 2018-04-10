class V1::CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone_number, :provinsi, :kabupaten, :kecamatan, :kelurahan, 
              :address, :point, :balance, :blocked
end
