require 'socket'
require './transmitters.rb'
require './morse_coder.rb'

class MorseServer
  HELLO = '.....'
  READY = 'ready'
  BYE = '-----'
  BYEBYE = 'bye bye'

  attr_accessor :port

  def initialize(bind_ip, port)
    @bind_ip = bind_ip
    @port = port
    @morse_coder = MorseCoder.new(DebugTransmitter.new)
  end
  
  def start
    puts "starting to listen on #{@bind_ip}:#{port}"
    @server = TCPServer.new @bind_ip, port # Server bind to port 2000
    @client = @server.accept     # Wait for a client to connect

    port, @ip = Socket.unpack_sockaddr_in(@client.getpeername)
    puts "accepted connection from #{@ip}"
  end
  
  def listen
    hello = @client.gets
    if hello != "#{HELLO}\n"
      puts "got #{hello.inspect} instead of '#{HELLO}\\n'"
      return false
    end
  
    puts 'hello received, sending ready signal'
    @client.puts READY
  
    loop do
      message = @client.gets
      if message.nil?
        puts 'client has disconnected'
        break
      else
        command = message.chomp
      end

      case command
      when BYE
        puts "thanks, bye bye #{@ip}"
        @client.puts BYEBYE
        break
      else
        begin
          result = @morse_coder.decode(command)
        rescue => e
          puts "got invalid message '#{command}' from #{@ip}"
          return false
        end
        puts "got message: '#{result}' from #{@ip}"
      end
    end
  
  rescue Errno::EPIPE # client closed connection gracefully
    puts 'client has disconnected'
  rescue => e
    puts e.message
    puts 'weird, bug in morse server, restarting'
  ensure
    stop 
  end
  
  def stop
    @client.puts "closing socket on port #{@port}" rescue Errno::EPIPE
    @server.close
  end
end
