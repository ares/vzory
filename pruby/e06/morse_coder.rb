require './morse.rb'

class MorseCoder
  class InvalidTransmitter < RuntimeError; end

  @@counter = 0

  def self.counter
    @@counter
  end

  def initialize(transmitter, separator = '|')
    raise InvalidTransmitter unless transmitter.respond_to?(:puts)
    @transmitter = transmitter
    @separator = '|'
  end

  # e.g. decode('....|.|.-..|.-..|--- .--|---|.-.|.-..|-..') should return 'hello world'
  def decode(string)
    @@counter += 1
    string.split(' ').map do |word|
      word.split(@separator).map { |char| MORSE.detect { |k, v| v == char}[0] }.join
    end.join(' ')
  end
  
  
  # e.g. encode('hello world') should return '....|.|.-..|.-..|--- .--|---|.-.|.-..|-..'
  def encode(string)
    @@counter += 1
    string.split(' ').map do |word|
      word.chars.map { |char| MORSE[char] }.join(@separator)
    end.join(' ')
  end

  def verify(string)
    decode(encode(string)) == string
  end

  def transmit(message)
    @transmitter.puts encode(message)
  end

  def method_missing(name, *args, &block)
    name = name.to_s
    if ('a'..'z').include?(name)
      encode(name)
    else
      super
    end
  end

  def respond_to_missing(name, include_private = false)
    ('a'..'z').include?(name.to_s) or super
  end
end
