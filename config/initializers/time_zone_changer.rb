class ActiveSupport::TimeWithZone
    def as_json(options = {})
        @namahari = ["Minggu", "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"]
        @hari = @namahari[to_datetime.strftime("%a").to_i]
        @tanggal = strftime("%d").to_i
        @namabulan = ["Januari", "February", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"]
        @bulan = @namabulan[to_datetime.strftime("%m").to_i]
        @tahun = to_datetime.strftime("%Y")
        @waktu = to_datetime.strftime("%H:%M %Z")
        "#{@hari}, #{@tanggal} #{@bulan} #{@tahun}, pukul #{@waktu}"
    end
end