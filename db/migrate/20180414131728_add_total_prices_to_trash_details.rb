class AddTotalPricesToTrashDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :trash_details, :total_price, :integer
  end
end
