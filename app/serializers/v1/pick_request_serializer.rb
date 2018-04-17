class V1::PickRequestSerializer < ActiveModel::Serializer
  attributes :id, :pr_id, :customer_address, :amount, :created_at, :status, :comment, :confirmed_at

  belongs_to :branch
  belongs_to :customer
  has_many :trash_details

  def created_at
    @day = object.created_at.strftime("%A")
    day_changer(@day)
    @tanggal = object.created_at.strftime("%d").to_i
    @namabulan = ["", "Januari", "February", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"]
    @bulan = @namabulan[object.created_at.strftime("%m").to_i]
    @tahun = object.created_at.strftime("%Y")
    @waktu = object.created_at.strftime("%H:%M %Z")
    "#{@hari}, #{@tanggal} #{@bulan} #{@tahun}, pukul #{@waktu}"
  end

  def confirmed_at
    @day = object.updated_at.strftime("%A")
    day_changer(@day)
    @tanggal = object.updated_at.strftime("%d").to_i
    @namabulan = ["", "Januari", "February", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"]
    @bulan = @namabulan[object.updated_at.strftime("%m").to_i]
    @tahun = object.updated_at.strftime("%Y")
    @waktu = object.updated_at.strftime("%H:%M %Z")
    "#{@hari}, #{@tanggal} #{@bulan} #{@tahun}, pukul #{@waktu}"
  end

  def day_changer(day)
    case day
        when "Sunday"
            @hari = "Minggu"
        
        when "Monday"
            @hari = "Senin"

        when "Tuesday"
            @hari = "Selasa"

        when "Wednesday"
            @hari = "Rabu"

        when "Thursday"
            @hari = "Kamis"

        when "Friday"
            @hari = "Jumat"

        when "Saturday"
            @hari = "Sabtu"
    end
  end
end
