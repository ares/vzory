require './morse.rb'

class MorseCoder
  def self.counter
    @@counter || 0
  end

  def initialize(separator = '|')
    @separator = '|'
    @@counter = 0
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
end
