require './e01_implementing_basic_methods.rb'

require "minitest/autorun"

class TestE01 < Minitest::Test
  def setup
    @string = 'abcdefghijkl'
  end

  def test_separated_by
    assert separated_by?(@string, 'a', 'c', 'b')
    refute separated_by?(@string, 'a', 'c', 'd')
    assert separated_by?(@string, 'a', 'd', 'bc')
    refute separated_by?(@string, 'a', 'b', nil)
    assert separated_by?(@string, 'a', 'b', '')
    assert separated_by?(@string, 'c', 'g', 'def')
    assert separated_by?(@string + 'axb', 'a', 'b', 'x')
    assert separated_by?(@string + 'axb', 'a', 'b', @string[1..-1] + 'ax')
  end

  def test_palindrom
    assert palindrom?('')
    assert palindrom?('a')
    assert palindrom?('abba')
    assert palindrom?('krk')
    refute palindrom?('bab ')
    refute palindrom?('bba')
  end

  def test_palindroms_count
    assert_equal 0, palindroms_count([])
    assert_equal 1, palindroms_count(['aba'])
    assert_equal 2, palindroms_count(['bab', 'aba'])
    assert_equal 2, palindroms_count(['aba', 'aab', 'abba'])
    assert_equal 0, palindroms_count(['xy', 'yx'])
    assert_equal 2, palindroms_count(['a', 'b', 1])
  end

  def test_power_of_2
    assert power_of_2?(2)
    assert power_of_2?(4)
    assert power_of_2?(8)
    assert power_of_2?(1)
    refute power_of_2?(6)
    refute power_of_2?(0)
    refute power_of_2?(7)
    refute power_of_2?(5)
  end

  def test_build_hash_from
    assert_equal({}, build_hash_from([], []))
    assert_equal({:a => nil}, build_hash_from([:a], []))
    assert_equal({:a =>'y', :b => 'x'}, build_hash_from([:a, :b], ['y', 'x']))
    assert_equal({:a => 'x'}, build_hash_from([:a], ['x', 'y', 'z']))
  end
end
