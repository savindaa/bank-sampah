class CreateAcctTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :acct_transactions do |t|
      t.string  :tr_id
      t.string  :transaction_type_id
      t.integer :customer_id
      t.string  :customer_phone_number
      t.integer :branch_id
      t.string  :branch_name
      t.integer :amount, default: 0
      t.integer :point_received, default: 0
      t.integer :adjusted_bal
      t.boolean :approved, default: false

      t.timestamps
    end
    add_index :acct_transactions, :tr_id
    add_index :acct_transactions, :customer_id
    add_index :acct_transactions, :customer_phone_number
    add_index :acct_transactions, :branch_id
    add_index :acct_transactions, :branch_name
    add_index :acct_transactions, :approved
  end
end
