class V1::PickRequestSerializer < ActiveModel::Serializer
  attributes :id, :pr_id, :customer_address, :amount, :created_at, :status, :comment, :confirmed_at

  belongs_to :branch
  belongs_to :customer
  has_many :trash_details

  def created_at
    object.created_at.strftime "%d-%m-%Y %H:%M:%S %Z"
  end

  def confirmed_at
    object.updated_at.strftime "%d-%m-%Y %H:%M:%S %Z"
  end
end
