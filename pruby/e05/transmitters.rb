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
