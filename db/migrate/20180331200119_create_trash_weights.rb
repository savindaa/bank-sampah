class CreateTrashWeights < ActiveRecord::Migration[5.1]
  def change
    create_table :trash_weights do |t|
      t.decimal :plastik
      t.decimal :kertas
      t.decimal :botol
      t.decimal :besi
      t.decimal :other
      t.integer :need_detail_id
      t.string  :need_detail_type

      t.timestamps
    end
    add_index :trash_weights, [:need_detail_id, :need_detail_type]
  end
end
