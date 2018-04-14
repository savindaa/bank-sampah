module MyLogger
    def log(message, message_color: :green)
        puts '~' * 10
        puts "DateTime: #{DateTime.now}"
        puts '~' * 10
        puts message.try(message_color)
        puts '~' * 10
    end

    module_function :log
end