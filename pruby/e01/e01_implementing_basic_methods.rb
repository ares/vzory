# returns true if +a and +b substrings are separated by +separator in a +string
# returns false otherwise
# see http://ruby-doc.org/core/String.html for help
def separated_by?(string, a, b, separator)
  return false if separator.nil?
  string.include? a + separator + b
end

# returns true if +string reads the same way from both ends, e.g. krk
# returns false otherwise
def palindrom?(string)
  return false unless string.is_a?(String)
  string == string.reverse
end

# return count of palindroms in +array
def palindroms_count(array)
  # this implementation could have been oneliner
  n = 0
  for i in (0..array.size-1)
    n = n + 1 if palindrom?(array[i])
  end
  n
end

# returns true if +number is power of 2, e.g. 4, 8, 16
# returns false otherwise
def power_of_2?(number)
  for i in (0..number)
    current_result = 2 ** i
    return true if current_result == number
    return false if current_result > number
  end
end

# returns a hash, +keys is an array of keys, +values is an array of values
# so that build_hash_from([1, 'a'], ['one', 'A']) will return { 1 => 'one', 'a' => 'A' }
# hash should have as many entries as keys, if there are no values for keys use nil
def build_hash_from(keys, values)
  hash = {}
  for i in (0..keys.size-1)
    hash[keys[i]] = values[i]
  end
  hash
end


