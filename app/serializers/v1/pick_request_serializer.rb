class V1::PickRequestSerializer < ActiveModel::Serializer
  attributes :id, :pr_id, :provinsi, :kabupaten, :kecamatan, :kelurahan, :customer_address,
             :amount, :created_at, :branch_name, :status, :comment, :confirmed_at

  belongs_to :customer
  has_one :trash_weight

  def created_at
    object.created_at.strftime "%d-%m-%Y %H:%M:%S %Z"
  end

  def confirmed_at
    object.updated_at.strftime "%d-%m-%Y %H:%M:%S %Z"
  end
end
