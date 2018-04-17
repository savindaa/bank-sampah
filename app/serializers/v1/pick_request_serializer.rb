class V1::PickRequestSerializer < ActiveModel::Serializer
  attributes :id, :pr_id, :customer_address, :amount, :created_at, :status, :comment, :confirmed_at

  belongs_to :branch
  belongs_to :customer
  has_many :trash_details

  def created_at
    @namahari = ["Minggu", "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"]
    @hari = @namahari[object.created_at.in_time_zone('Jakarta').strftime("%a").to_i]
    @tanggal = object.created_at.in_time_zone('Jakarta').strftime("%d").to_i
    @namabulan = ["Januari", "February", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"]
    @bulan = @namabulan[object.created_at.in_time_zone('Jakarta').strftime("%m").to_i]
    @tahun = object.created_at.in_time_zone('Jakarta').strftime("%Y")
    @waktu = object.created_at.in_time_zone('Jakarta').strftime("%H:%M %Z")
    "#{@hari}, #{@tanggal} #{@bulan} #{@tahun}, pukul #{@waktu}"
  end

  def confirmed_at
    @namahari = ["Minggu", "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"]
    @hari = @namahari[object.updated_at.in_time_zone('Jakarta').strftime("%a").to_i]
    @tanggal = object.updated_at.in_time_zone('Jakarta').strftime("%d").to_i
    @namabulan = ["Januari", "February", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"]
    @bulan = @namabulan[object.updated_at.in_time_zone('Jakarta').strftime("%m").to_i]
    @tahun = object.updated_at.in_time_zone('Jakarta').strftime("%Y")
    @waktu = object.updated_at.in_time_zone('Jakarta').strftime("%H:%M %Z")
    "#{@hari}, #{@tanggal} #{@bulan} #{@tahun}, pukul #{@waktu}"
  end
end
