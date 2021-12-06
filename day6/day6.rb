class School
  def initialize(input_arr)
    @school = {}
    input_arr.group_by(&:itself).map do |key, value|
      @school[key] = value.count
    end
  end

  def spawn_new_lanternfish!
    @school[9] = @school[0] || 0
    @school[7] = (@school[0] || 0) + (@school[7] || 0)
  end

  def update_internal_timers!
    (0..9).each do |grouping|
      @school[grouping] = @school[grouping + 1] || 0
    end
  end

  def cycle!
    spawn_new_lanternfish!
    update_internal_timers!
  end

  def simulate!(days)
    return score if days.zero?

    cycle!
    simulate!(days - 1)
  end

  def score
    @school.values.sum
  end
end

module Day6
  def part1(filename, days)
    lanternfishes = parse_input(filename)
    School.new(lanternfishes).simulate!(days)
  end

  def parse_input(filename)
    file = File.open(filename)
    input = file.readlines.first.chomp.split(',').map(&:to_i)
    file.close
    input
  end
end
