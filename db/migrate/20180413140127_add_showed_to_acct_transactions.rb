class AddShowedToAcctTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :acct_transactions, :showed, :boolean, default: true
    add_index :acct_transactions, :showed
  end
end
