class CreateVouchers < ActiveRecord::Migration[5.1]
  def change
    create_table :vouchers do |t|
      t.string  :name
      t.string  :category
      t.integer :point_needed
      t.string  :description
      t.string  :picture
      t.boolean :active, default: true

      t.timestamps
    end
    add_index :vouchers, :category
    add_index :vouchers, :active
  end
end
