class V1::AcctTransactionSerializer < ActiveModel::Serializer
  attributes :id, :tr_id, :transaction_type_id, :customer_phone_number, 
              :amount, :point_received, :created_at, :adjusted_bal, :branch_name, :approved, :confirmed_at

  has_one :trash_weight

  def created_at
    object.created_at.strftime "%d-%m-%Y %H:%M:%S %Z"
  end

  def confirmed_at
    object.updated_at.strftime "%d-%m-%Y %H:%M:%S %Z"
  end
end
