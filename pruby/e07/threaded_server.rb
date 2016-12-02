require './morse_server'

ip = '192.168.1.164'
threads = []
20.times do |i|
  m = MorseServer.new(ip, 2000 + i)
  threads << Thread.new do
    loop do
      m.start
      m.listen
    end
  end
end

threads.each &:join
