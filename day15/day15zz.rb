module Day15zz
  def solution(filename)
    lines = parse_input(filename)
    rows = lines.count * 5
    cols = lines.first.split('').length * 5

    @cave = initialize_cave(lines)
    graph = @cave.dup

    distances = dijkstra(graph, [0, 0])
    distances[[rows - 1, cols - 1]]
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

    rows = lines.count
    cols = lines.first.split('').length

    lines.each_with_index do |line, row|
      line.split('').map(&:to_i).each_with_index do |risk_level, col|
        cave[[row, col]] = risk_level
      end
    end

    og_cave = cave.dup

    (0...5).to_a.each do |row_multiplier|
      (0...5).to_a.each do |col_multiplier|
        next if row_multiplier == 0 && col_multiplier == 0

        og_cave.each do |vertex, risk_level|
          row = vertex.first
          col = vertex.last

          new_risk_level = cave[[row, col]] + row_multiplier + col_multiplier
          new_risk_level -= 9 while new_risk_level > 9
          cave[[row + (row_multiplier * rows), col + (col_multiplier * cols)]] = new_risk_level
        end
      end
    end

    cave
  end

  def parse_input(filename)
    File.read(filename).split("\n")
  end
end
