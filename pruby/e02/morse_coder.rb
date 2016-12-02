require './morse.rb'

# e.g. decode('....|.|.-..|.-..|--- .--|---|.-.|.-..|-..') should return 'hello world'
def decode(string)
  string.split(' ').map do |word|
    word.split('|').map { |char| MORSE.detect { |k, v| v == char}[0] }.join
  end.join(' ')
end

puts decode('....|.|.-..|.-..|--- .--|---|.-.|.-..|-..')

# e.g. encode('hello world') should return '....|.|.-..|.-..|--- .--|---|.-.|.-..|-..'
def encode(string)
  string.split(' ').map do |word|
    word.chars.map { |char| MORSE[char] }.join('|')
  end.join(' ')
end

puts encode('hello world')
