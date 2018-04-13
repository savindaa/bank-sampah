class RemoveProvinsiFromPickRequests < ActiveRecord::Migration[5.1]
  def change
    remove_column :pick_requests, :provinsi, :string
    remove_column :pick_requests, :kabupaten, :string
    remove_column :pick_requests, :kecamatan, :string
    remove_column :pick_requests, :kelurahan, :string
    remove_column :pick_requests, :branch_name, :string
  end
end
