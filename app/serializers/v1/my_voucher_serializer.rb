class V1::MyVoucherSerializer < ActiveModel::Serializer
  attributes :id, :voucher_id, :used

  belongs_to :voucher
end
