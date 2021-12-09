class CrabFleet
  def initialize(positions)
    @positions = positions
    @cached_total_fuel = {}
  end

  def total_fuel_to_destination(destination, method)
    cached_total_fuel = @cached_total_fuel[destination]
    return cached_total_fuel unless cached_total_fuel.nil?

    fuel = @positions.map do |position|
      send(method, position, destination)
    end.sum

    @cached_total_fuel[destination] = fuel
  end

  def crab_fuel_simple(position, destination)
    (position - destination).abs
  end

  def crab_fuel_complex(position, destination)
    distance = (position - destination).abs
    distance * (distance + 1) / 2
  end
end

module Day10
  def part1(filename)
    positions = parse_input(filename)
    crab_fleet = CrabFleet.new(positions)

    (positions.min..positions.max).map do |potential_destination|
      crab_fleet.total_fuel_to_destination(potential_destination, :crab_fuel_simple)
    end.min
  end

  def part2(filename)
    positions = parse_input(filename)
    crab_fleet = CrabFleet.new(positions)

    (positions.min..positions.max).map do |potential_destination|
      crab_fleet.total_fuel_to_destination(potential_destination, :crab_fuel_complex)
    end.min
  end

  def parse_input(filename)
    file = File.open(filename)
    input = file.readlines.first.chomp.split(',').map(&:to_i)
    file.close
    input
  end
end
