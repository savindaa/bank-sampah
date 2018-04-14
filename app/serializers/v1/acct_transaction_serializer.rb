class V1::AcctTransactionSerializer < ActiveModel::Serializer
  attributes :id, :tr_id, :transaction_type_id, :customer_phone_number, :amount, :created_at, :branch_name, :approved, :showed, :comment, :confirmed_at

  has_many :trash_details

  def created_at
    object.created_at.strftime "%d-%m-%Y %H:%M:%S %Z"
  end

  def confirmed_at
    object.updated_at.strftime "%d-%m-%Y %H:%M:%S %Z"
  end
end
