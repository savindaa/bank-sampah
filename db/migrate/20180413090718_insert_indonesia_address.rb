class InsertIndonesiaAddress < ActiveRecord::Migration[5.1]
  def self.up
    Indonesia.provinces.each do |p|
      Province.create(code: p[:id], name: p[:name])
    end

    Indonesia.regencies.each do |r|
      Regency.create(code: r[:id], name: r[:name], province_code: r[:province_id])
    end

    Indonesia.districts.each do |d|
      District.create(code: d[:id], name: d[:name], regency_code: d[:regency_id])
    end

    Indonesia.villages.each do |v|
      Village.create(code: v[:id], name: v[:name], district_code: v[:district_id])
    end
  end

  def self.down
    Province.destroy_all
    Regency.destroy_all
    District.destroy_all
    Village.destroy_all
  end
end
