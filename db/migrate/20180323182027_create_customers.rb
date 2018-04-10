class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string  :name
      t.string  :phone_number
      t.string  :password_digest
      t.string  :provinsi
      t.string  :kabupaten
      t.string  :kecamatan
      t.string  :kelurahan
      t.string  :address
      t.integer :point, default: 0
      t.integer :balance, default: 0
      t.string  :profile_picture
      t.boolean :blocked, default: false

      t.timestamps
    end
    add_index :customers, :phone_number
  end
end
