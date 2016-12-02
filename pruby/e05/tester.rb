#!/usr/bin/env ruby

require './morse_coder.rb'
require './transmitters.rb'

puts MorseCoder.new(nil).a
puts MorseCoder.new(nil).b

MorseCoder.new(StandardTransmitter.new).transmit('hello world')
MorseCoder.new(DebugTransmitter.new).transmit('hello world')
MorseCoder.new(nil).transmit('hello world')
