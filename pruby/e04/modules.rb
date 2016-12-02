module StringExtensions
  def separated_by?(a, b, separator)
    return false if separator.nil?
    self.include? a + separator + b
  end

  def palindrom?
    self == self.reverse
  end

end

module NumericExtensions
  def power_of_2?
    (0..self).any? { |i| 2.0 ** i == self.to_f }
  end
end

module ArrayExtensions
  def palindroms_count
    self.select{ |i| palindrom?(i) }.count
  end
end

String.include StringExtensions
Numeric.include NumericExtensions
Array.include ArrayExtensions

module MorseCoderExtensions
  def encode(*args)
    result = super
    result.tr(' ', "\n")
  end
end

#require '../e03/morse_coder.rb'
#MorseCoder.prepend MorseCoderExtensions

puts MorseCoder.new.encode("hello world")
