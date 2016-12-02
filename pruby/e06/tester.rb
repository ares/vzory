#!/usr/bin/env ruby

require './morse_coder.rb'
require './transmitters.rb'

c = MorseCoder.new(DebugTransmitter.new)
begin
  File.open(ARGV[0] || 'morse_input.txt', 'r') do |file|
    until file.eof?
      c.transmit file.gets
    end
  end
rescue => e
  puts 'File could not be opened'
  puts e.message
end

# should raise
begin
  MorseCoder.new(nil)
rescue MorseCoder::InvalidTransmitter
  puts "check passed"
end

file = File.open('morse_output.txt', 'w') # r would print error
#transmitter = FileTransmitter.new(file)
c = MorseCoder.new(file)
c.transmit "hello world\nfrom another\n\nscript"
file.close

