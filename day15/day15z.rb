module Day15z
  def solution(filename)
    lines = parse_input(filename)
    @rows = lines.count
    @cols = lines.first.split('').length
    @cave = initialize_cave(lines)

    graph = @cave.dup
    distances = dijkstra(graph, [0, 0])
    distances[[@rows - 1, @cols - 1]]
  end

  def dijkstra(graph, source)
    set_q = {}
    dist = {}

    graph.each do |v, risk_level|
      set_q[v] = {}
      set_q[v][:risk_level] = risk_level
      set_q[v][:dist] = 1_000_000

      dist[v] = 1_000_000
    end

    dist[source] = 0
    set_q[source][:dist] = 0

    while set_q.empty? == false
      u = set_q.min_by { |_, v| v[:dist] }.first
      puts set_q.count
      set_q.delete(u)

      x, y = u
      [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]].each do |v|
        next if set_q[v].nil?

        alt = dist[u] + graph[v]
        next unless alt < dist[v]

        dist[v] = alt
        set_q[v][:dist] = alt
      end
    end

    dist
  end

  def initialize_cave(lines)
    cave = {}

    lines.each_with_index do |line, row|
      line.split('').map(&:to_i).each_with_index do |risk_level, col|
        cave[[row, col]] = risk_level
      end
    end

    cave
  end

  def parse_input(filename)
    File.read(filename).split("\n")
  end
end
