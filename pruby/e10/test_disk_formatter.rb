require 'minitest/autorun'
require 'ostruct'
require './disk_formatter.rb'

class TestDiskFormatter < Minitest::Test
  def setup
    @supported_hdd = OpenStruct.new :file_system => 'ext2'
    @unsupported_hdd = OpenStruct.new :file_system => 'fat'
  end

  def test_supported?
    assert DiskFormatter.new(@supported_hdd).supported?
    refute DiskFormatter.new(@unsupported_hdd).supported?
  end

  def test_supported_uses_file_system
    mock = Minitest::Mock.new
    mock.expect :file_system, 'ext2'
    DiskFormatter.new(mock).supported?
    assert mock.verify
  end

  def test_formating
    @supported_hdd.size = 1_000
    @supported_hdd.block_size = 10
    f = DiskFormatter.new(@supported_hdd)
    f.stub(:format_block, true) do
      assert_equal 'done', f.format!
    end
  end
end
