module Day12b
  def solution_b(filename)
    lines = parse_input(filename)
    @connections = Hash.new { |h, k| h[k] = [] }
    @paths = []

    lines.each do |line|
      start, finish = line.split('-')
      @connections[start] << finish
      @connections[finish] << start
    end

    traverse(['start'])

    @paths.count
  end

  def traverse(path)
    if path.last == 'end'
      @paths << path
      return
    end

    finishing_segments = @connections[path.last]
    finishing_segments.each do |finishing_segment|
      next if path.include?(finishing_segment) && finishing_segment == 'start'
      next if path.include?(finishing_segment) && finishing_segment == 'end'

      small_cave_counts = Hash.new(0)
      path
        .select { |e| e == e.downcase }
        .each { |value| small_cave_counts[value] += 1 }

      next if small_cave_counts.keys.include?(finishing_segment) &&
              small_cave_counts.values.any? { |value| value == 2 }

      traverse(path + [finishing_segment])
    end
  end

  def parse_input(filename)
    File.read(filename).split("\n")
  end
end
