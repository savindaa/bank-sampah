class CreatePickRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :pick_requests do |t|
      t.string  :pr_id
      t.integer :customer_id
      t.string  :provinsi
      t.string  :kabupaten
      t.string  :kecamatan
      t.string  :kelurahan
      t.string  :customer_address
      t.integer :branch_id
      t.string  :branch_name
      t.integer :amount, default: 0
      t.integer :point_received, default: 0
      t.string  :status, default: "1"
      t.string  :comment

      t.timestamps
    end
    add_index :pick_requests, :pr_id
    add_index :pick_requests, :customer_id
    add_index :pick_requests, :branch_id
    add_index :pick_requests, :status
  end
end
