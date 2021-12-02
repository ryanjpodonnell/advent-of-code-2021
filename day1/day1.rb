def parse_input
  File.read('input.txt').split("\n")
end

def depth_increasement_count(depths)
  depth_measurment_increasement_count = 0

  depths.each_cons(2) do |(previous_depth, next_depth)|
    depth_measurment_increasement_count += 1 if next_depth > previous_depth
  end

  depth_measurment_increasement_count
end

def part1
  depths = parse_input.map(&:to_i)
  depth_increasement_count(depths)
end

def part2
  depths = parse_input.map(&:to_i)
  depth_sums = depths.each_cons(3).map(&:sum)
  depth_increasement_count(depth_sums)
end

puts part1
puts part2
