require 'socket'
require 'timeout'

# bez threadu
# ruby scanner.rb localhost 1 65535  3,85s user 6,12s system 108% cpu 9,152 total
# s 20 workery
# ruby scanner.rb localhost 1 65535 20  5,50s user 10,13s system 215% cpu 7,250 total
#

class Scan
  attr_accessor :target, :port

  def initialize(target, port)
    @target = target
    @port = port
  end

  def open?
    Timeout::timeout(2) do
      client = TCPSocket.new target, port
      client.puts 'ping'
      puts "port #{port} open!"
      return true
    end
  rescue Timeout::Error
    #puts "port #{port} filtered: timeout after 2 seconds"
    return false
  rescue => e
    #puts "port #{port} closed: #{e.message}"
    return false
  end
end

class Scanner
  attr_accessor :target, :from, :to, :workers_count

  def initialize(target, from, to, workers_count)
    @from = from
    @to = to
    @target = target
    @workers_count = workers_count
  end

  def scan
    queue = Queue.new
    (@from..@to).each { |port| queue.push port }
    workers = []
    workers_count.times do
      worker = Thread.new do |port|
        begin
          while (port = queue.pop(true)) do
            Scan.new(target, port).open?
          end
        rescue ThreadError
        end
      end
      workers.push worker
    end
    workers.each(&:join)
  end
end

Scanner.new(ARGV[0], ARGV[1].to_i, ARGV[2].to_i, ARGV[3].to_i).scan
