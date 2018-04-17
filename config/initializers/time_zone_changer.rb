class ActiveSupport::TimeWithZone
    def as_json(options = {})
        @namahari = ["Minggu", "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"]
        @hari = @namahari[in_time_zone('Jakarta').strftime("%a").to_i]
        @tanggal = in_time_zone('Jakarta').strftime("%d").to_i
        @namabulan = ["Januari", "February", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"]
        @bulan = @namabulan[in_time_zone('Jakarta').strftime("%m").to_i]
        @tahun = in_time_zone('Jakarta').strftime("%Y")
        @waktu = in_time_zone('Jakarta').strftime("%H:%M %Z")
        "#{@hari}, #{@tanggal} #{@bulan} #{@tahun}, pukul #{@waktu}"
    end

    # def as_json(options = {})
    #     @namahari = ["Minggu", "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"]
    #     @hari = @namahari[strftime("%a").to_i]
    #     @tanggal = strftime("%d").to_i
    #     @namabulan = ["Januari", "February", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"]
    #     @bulan = @namabulan[strftime("%m").to_i]
    #     @tahun = strftime("%Y")
    #     @waktu = strftime("%H:%M %Z")
    #     "#{@hari}, #{@tanggal} #{@bulan} #{@tahun}, pukul #{@waktu}"
    # end
end