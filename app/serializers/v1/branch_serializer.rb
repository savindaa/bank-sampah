class V1::BranchSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone_number, :address, :balance
end
