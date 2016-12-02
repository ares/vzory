class StandardTransmitter
  def puts(str)
    Kernel.puts str
  end
end

class DebugTransmitter
  def puts(str)
    Kernel.puts "size: #{str.size}"
    Kernel.puts "message: #{str.inspect}"
  end
end

class FileTransmitter
  def initialize(f)
    @file = f
  end

  def puts(str)
    @file.puts str
  rescue => e
    Kernel.puts "could not trasmit data"
    Kernel.puts e.message
  end
end
