class Bike
  attr_accessor :max_front_gear, :max_rear_gear, :name, :color, :wheel_size, :current_rear_gear, :current_front_gear
  attr_reader :distance

  def self.registry
    @@registry || []
  end

  def initialize(max_front_gear:, max_rear_gear:, name:, color: nil, wheel_size: 26)
    @max_front_gear = max_front_gear
    @max_rear_gear = max_rear_gear
    @name = name
    @color = color
    @wheel_size = wheel_size
    @distance = 0
    @@registry ||= []
    @@registry.push self
    @current_rear_gear = 1
    @current_front_gear = 1
  end

  def current_gear
    "#{current_front_gear}x#{current_rear_gear}"
  end

  #def front_gear_up!
  #  shift('front', 'up')
  #end

  #def front_gear_down!
  #  shift('front', 'down')
  #end

  def method_missing(name, *args, &block)
    if name.to_s =~ /\A(front|rear)_gear_(up|down)!\Z/
      shift($1, $2)
    else
      super
    end
  end

  def respond_to_missing(name)
    name.to_s =~ /\A(front|rear)_gear_(up|down)!\Z/ or super
  end

  def go!
    @distance += current_front_gear * current_rear_gear * wheel_size / 10.0
  end

  def action
    case rand(10)
    when 0
      front_gear_up!
    when 1
      front_gear_down!
    when 2
      rear_gear_up!
    when 3
      rear_gear_down!
    else
      go!
    end
  end

  def to_s
    "#{name} (#{wheel_size}\"): najeto #{distance}"
  end

  private

  def shift(front_or_rear, direction)
    result = self.send("current_#{front_or_rear}_gear")
    condition_left = direction == 'up' ? send("current_#{front_or_rear}_gear") : 1
    condition_right = direction == 'up' ? send("max_#{front_or_rear}_gear") : send("current_#{front_or_rear}_gear")
    if condition_left < condition_right
      result += direction == 'up' ? 1 : -1
    end
    self.send("current_#{front_or_rear}_gear=", result)
  end
end

b = Bike.new name: 'favorit', max_front_gear: 3, max_rear_gear: 7
10.times { b.action }
puts b.to_s
