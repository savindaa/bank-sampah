class V1::BranchSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone_number, :provinsi, :kabupaten, :kecamatan, :kelurahan, :address, :balance
end
