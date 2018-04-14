class CreateTrashDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :trash_details do |t|
      t.string :item_name
      t.decimal :weight
      t.integer :need_detail_id
      t.string :need_detail_type

      t.timestamps
    end
    add_index :trash_details, [:need_detail_id, :need_detail_type]
  end
end
