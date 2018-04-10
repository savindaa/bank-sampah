class CreateBranches < ActiveRecord::Migration[5.1]
  def change
    create_table :branches do |t|
      t.string  :name
      t.string  :phone_number
      t.string  :password_digest
      t.string  :provinsi
      t.string  :kabupaten
      t.string  :kecamatan
      t.string  :kelurahan
      t.string  :address
      t.integer :balance, default: 0
      t.string  :profile_picture
      t.boolean :blocked, default: false

      t.timestamps
    end
    add_index :branches, :phone_number
    add_index :branches, :name
  end
end
