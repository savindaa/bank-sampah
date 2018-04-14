class AddCommentToAcctTransactions < ActiveRecord::Migration[5.1]
  def change
    # remove_index :acct_transactions, :approved
    # remove_column :acct_transactions, :approved, :boolean
    # remove_index :acct_transactions, :showed
    # remove_column :acct_transactions, :showed, :boolean
    # add_column :acct_transactions, :status, :string, default: "1"
    # add_index :acct_transactions, :status
    add_column :acct_transactions, :comment, :string
  end
end
