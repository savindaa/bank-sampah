class V1::CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone_number, :point, :balance, :blocked
end
