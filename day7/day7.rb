class FunStuff
  def initialize(positions)
    @positions = positions
    @cached_total_fuel = {}
    @cached_crab_fuel = {}
  end

  def total_fuel_to_destination(destination, method)
    cached_total_fuel = @cached_total_fuel[destination]
    return cached_total_fuel unless cached_total_fuel.nil?

    fuel = @positions.map do |position|
      send(method, position, destination)
    end.sum

    @cached_total_fuel[destination] = fuel
  end

  def crab_fuel1_to_destination(position, destination)
    (position - destination).abs
  end

  def crab_fuel2_to_destination(position, destination)
    distance = (position - destination).abs
    cached_crab_fuel = @cached_crab_fuel[distance]
    return cached_crab_fuel unless cached_crab_fuel.nil?

    total_distance = fuel2_calculation(0, distance, 1)
    @cached_crab_fuel[distance] = total_distance
  end

  def fuel2_calculation(total, distance, steps)
    return total if distance.zero?

    fuel2_calculation(total + steps, distance - 1, steps + 1)
  end
end

module Day7
  def part1(filename)
    positions = parse_input(filename)
    fun_stuff = FunStuff.new(positions)

    (positions.min..positions.max).map do |potential_destination|
      fun_stuff.total_fuel_to_destination(potential_destination, :crab_fuel1_to_destination)
    end.min
  end

  def part2(filename)
    positions = parse_input(filename)
    fun_stuff = FunStuff.new(positions)

    (positions.min..positions.max).map do |potential_destination|
      fun_stuff.total_fuel_to_destination(potential_destination, :crab_fuel2_to_destination)
    end.min
  end

  def parse_input(filename)
    file = File.open(filename)
    input = file.readlines.first.chomp.split(',').map(&:to_i)
    file.close
    input
  end
end
