class AddCommentToAcctTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :acct_transactions, :comment, :string
  end
end
