class CreateMyVouchers < ActiveRecord::Migration[5.1]
  def change
    create_table :my_vouchers do |t|
      t.integer :voucher_id
      t.integer :customer_id
      t.boolean :used, default: false

      t.timestamps
    end
  end
end
