class V1::AcctTransactionSerializer < ActiveModel::Serializer
  attributes :id, :tr_id, :transaction_type_id, :amount, :created_at, :status, :comment, :confirmed_at

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
