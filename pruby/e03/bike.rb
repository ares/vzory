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

  def front_gear_up!
    @current_front_gear += 1 if current_front_gear < max_front_gear
  end

  def front_gear_down!
    @current_front_gear -= 1 if current_front_gear > 1
  end

  def rear_gear_up!
    @current_rear_gear += 1 if current_rear_gear < max_rear_gear
  end

  def rear_gear_down!
    @current_rear_gear -= 1 if current_rear_gear > 1
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
end

#b = Bike.new name: 'favorit', max_front_gear: 3, max_rear_gear: 7
#10.times { b.action }
#puts b.to_s
