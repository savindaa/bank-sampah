class V1::AcctTransactionSerializer < ActiveModel::Serializer
  attributes :id, :tr_id, :transaction_type_id, :amount, :created_at, :status, :comment, :confirmed_at

  belongs_to :branch
  belongs_to :customer 
  has_many :trash_details

  def created_at
    @namahari = ["Minggu", "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"]
    @hari = @namahari[object.created_at.strftime("%a").to_i]
    @tanggal = object.created_at.strftime("%d").to_i
    @namabulan = ["Januari", "February", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"]
    @bulan = @namabulan[object.created_at.strftime("%m").to_i]
    @tahun = object.created_at.strftime("%Y")
    @waktu = object.created_at.strftime("%H:%M %Z")
    "#{@hari}, #{@tanggal} #{@bulan} #{@tahun}, pukul #{@waktu}"
  end

  def confirmed_at
    @namahari = ["Minggu", "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"]
    @hari = @namahari[object.updated_at.strftime("%a").to_i]
    @tanggal = object.updated_at.strftime("%d").to_i
    @namabulan = ["Januari", "February", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"]
    @bulan = @namabulan[object.updated_at.strftime("%m").to_i]
    @tahun = object.updated_at.strftime("%Y")
    @waktu = object.updated_at.strftime("%H:%M %Z")
    "#{@hari}, #{@tanggal} #{@bulan} #{@tahun}, pukul #{@waktu}"
  end
end
