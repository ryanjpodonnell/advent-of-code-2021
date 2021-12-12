module Day12a
  def solution_a(filename)
    lines = parse_input(filename)
    @connections = Hash.new {|h,k| h[k] = Array.new }
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
      next if path.include?(finishing_segment) && finishing_segment.downcase == finishing_segment

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
