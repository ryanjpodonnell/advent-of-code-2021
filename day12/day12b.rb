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

    @paths.select { |path| path[-1] == 'end' }.uniq.count
  end

  def traverse(path)
    connection = @connections.find { |start, _| start == path[-1] }
    return if connection.nil?

    finishing_segments = connection.last

    paths = finishing_segments.map do |finishing_segment|
      next if path.include?(finishing_segment) && finishing_segment == 'start'
      next if path.include?(finishing_segment) && finishing_segment == 'end'

      small_cave_counts = path
                          .select { |e| e == e.downcase && e != 'start' && e != 'end' }
                          .each_with_object(Hash.new(0)) { |cave, counts| counts[cave] += 1 }

      next if small_cave_counts.keys.include?(finishing_segment) &&
              small_cave_counts.values.any? { |value| value == 2 }

      path + [finishing_segment]
    end.compact

    paths.each do |p|
      if p[-1] == 'end'
        @paths << p
      else
        traverse(p)
      end
    end
  end

  def parse_input(filename)
    File.read(filename).split("\n")
  end
end
