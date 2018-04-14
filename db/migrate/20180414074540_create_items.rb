class CreateItems < ActiveRecord::Migration[5.1]
  def self.up
    create_table :items do |t|
      t.string :name, null: false
      t.integer :price, null: false
    end

    add_index :items, :name
  end

  def self.down
    drop_table :items
  end
end
