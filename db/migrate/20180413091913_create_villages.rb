class CreateVillages < ActiveRecord::Migration[5.1]
  def self.up
    create_table :villages, id: false do |t|
      t.integer :code, null: false, primary: true, limit: 8
      t.integer :district_code, null: false
      t.string :name, null: false
    end

    add_index :villages, :district_code
  end

  def self.down
    drop_table :villages
  end
end
