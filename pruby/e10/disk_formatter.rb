class DiskFormatter
  SUPPORTED_FILE_SYSTEMS = [ 'ext2', 'ext3', 'xfs', 'afs' ]
  attr_reader :hdd

  def initialize(hdd)
    @hdd = hdd
  end

  def supported?
    SUPPORTED_FILE_SYSTEMS.include?(hdd.file_system)
  end

  def blocks_aligned?
    hdd.size % hdd.block_size == 0
  end

  def format!
    raise IOError, 'unsupported FS' unless supported?
    raise IOError, 'blocks not aligned' unless blocks_aligned?

    (hdd.size / hdd.block_size).to_i.times do |block|
      format_block(block * hdd.block_size, (block + 1) * hdd.block_size - 1)
    end

    'done'
  end

  private

  def format_block(start_address, end_address)
    # IO magic happens here
    sleep(1)
  end
end
