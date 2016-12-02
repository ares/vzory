require 'socket'
require 'timeout'

def build_client
  sleep 1
  TCPSocket.new ARGV[0] || 'localhost', ARGV[1] || 2000
end

def check_reply(client, message)
  Timeout::timeout(3) do
    print "#{message} reply: "
    if client.gets == "#{message}\n"
      puts 'OK'
    else
      puts 'failed'
    end
  end
end

# happy path
client = build_client
client.puts '.....'

check_reply client, 'ready' 
client.puts '....|.. -|.-.|.-|--'
client.puts '..|- .--|---|.-.|-.-|...'
client.puts '-----'
check_reply client, 'bye bye'

client.close

puts "Happy path: OK"

# without hello
client = build_client

client.puts '.-'
client.close

puts "Without hello: OK"

# invalid message
client = build_client

client.puts '.....'
client.puts 'invalid'
client.close

puts "Invalid message: OK"

# server replies
client = build_client
client.puts '.....'
check_reply(client, 'ready')
client.puts '-----'
check_reply(client, 'bye bye')
