class V1::VoucherSerializer < ActiveModel::Serializer
  attributes :id, :name, :category, :point_needed, :description, :active
end
