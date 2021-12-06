class School
  def initialize(input_arr)
    @school = initialize_school(input_arr)
  end

  def initialize_school(input_arr)
    school = input_arr.group_by { |lanternfish| lanternfish }
    school.map do |key, value|
      school[key] = value.count
    end
    (0..9).each { |grouping| school[grouping] = 0 if school[grouping].nil? }
    school
  end

  def spawn_new_lanternfish!
    @school[9] = @school[0]
    @school[7] = @school[0] + @school[7]
  end

  def update_internal_timers!
    (0..8).each do |grouping|
      @school[grouping] = @school[grouping + 1]
    end
    @school[9] = 0
  end

  def cycle!
    spawn_new_lanternfish!
    update_internal_timers!
  end

  def simulate!(days)
    return @school.count if days.zero?

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
    school = School.new(lanternfishes)
    school.simulate!(days)
    school.score
  end

  def parse_input(filename)
    file = File.open(filename)
    input = file.readlines.first.chomp.split(',').map(&:to_i)
    file.close
    input
  end
end
