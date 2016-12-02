require './bike.rb'

class Race
  def initialize(bikes, distance)
    @bikes = bikes
    @distance = distance
    @queue = []
  end

  def start
    Thread.abort_on_exception = true
    @queue = Queue.new
    threads = @bikes.map do |bike|
      Thread.new(bike) do |bike|
t1 = Time.now
        while bike.distance < @distance
          bike.action
          sleep 1
        end
        @queue.push bike
t2 = Time.now
puts "#{bike.name}: puts #{t2-t1}" # skutecny cas muze byt trosku jiny nez poradi dokonceni thready - tento vypis trva kazdemu jinak dlouho
      end
    end
    threads.each(&:join)
  end

  def print_results
    i = 1
    while i <= @bikes.size
      puts "#{i}. #{@queue.pop.to_s}"
      i += 1
    end
  end
end


11.times do |i|
  Bike.new(max_front_gear: rand(3)+1, max_rear_gear: rand(9)+1, name: "kolo_#{i}" )
end


race = Race.new(Bike.registry, 10)
race.start
race.print_results

