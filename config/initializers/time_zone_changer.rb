class ActiveSupport::TimeWithZone
    def as_json(options = {})
        @namahari = ["Minggu", "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"]
        @hari = @namahari[strftime("%a").to_i]
        @tanggal = strftime("%d").to_i
        @namabulan = ["Januari", "February", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"]
        @bulan = @namabulan[strftime("%m").to_i]
        @tahun = strftime("%Y")
        @waktu = strftime("%H:%M %Z")
        "#{@hari}, #{@tanggal} #{@bulan} #{@tahun}, pukul #{@waktu}"
    end
end