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

    @paths.count
  end

  def traverse(path)
    if path.last == 'end'
      @paths << path
      return
    end

    finishing_segments = @connections[path.last]
    finishing_segments.each do |finishing_segment|
      next if path.include?(finishing_segment) &&
              finishing_segment.downcase == finishing_segment

      traverse(path + [finishing_segment])
    end
  end

  def parse_input(filename)
    File.read(filename).split("\n")
  end
end
