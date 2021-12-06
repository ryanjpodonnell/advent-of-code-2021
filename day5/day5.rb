Square = Struct.new(:row, :column)

class Segment
  attr_reader :point1, :point2, :points

  def initialize(point1, point2)
    @point1 = point1
    @point2 = point2
    @points = [point1, point2]
  end

  def path
    if @point1.row == @point2.row
      smaller_point = @points.min_by(&:column)
      larger_point = @points.max_by(&:column)
      (smaller_point.column..larger_point.column).map { |column| [@point1.row, column] }
    elsif @point1.column == @point2.column
      smaller_point = @points.min_by(&:row)
      larger_point = @points.max_by(&:row)
      (smaller_point.row..larger_point.row).map { |row| [row, @point1.column] }
    end
  end

  def path_diagonal
    points = []
    smaller_point_by_column = @points.min_by(&:column)
    larger_point_by_column = @points.max_by(&:column)
    row = smaller_point_by_column.row

    if smaller_point_by_column.row < larger_point_by_column.row
      (smaller_point_by_column.column..larger_point_by_column.column).each do |column|
        points << [row, column]
        row += 1
      end
    else
      (smaller_point_by_column.column..larger_point_by_column.column).each do |column|
        points << [row, column]
        row -= 1
      end
    end

    points
  end
end

class Board
  attr_reader :squares

  def initialize(segments, diagonals = false)
    @segments = segments
    @squares = {}
    @diagonals = diagonals
    parse_input!
  end

  def parse_input!
    @segments.each do |segment|
      path = if @diagonals
               segment.path || segment.path_diagonal
             else
               segment.path
             end
      next if path.nil?

      path.each do |row, column|
        value = @squares["#{row}x#{column}"]
        if value.nil? == false
          @squares["#{row}x#{column}"] += 1
        else
          @squares["#{row}x#{column}"] = 1
        end
      end
    end
  end

  def score
    @squares.values.select { |value| value > 1 }.count
  end
end

module Day5
  def part_1(filename)
    segments = parse_input(filename)
    board = Board.new(segments)
    board.score
  end

  def part_2(filename)
    segments = parse_input(filename)
    board = Board.new(segments, true)
    board.score
  end

  def parse_input(filename)
    file = File.open(filename)
    segments_input = file.readlines.map(&:chomp)
    file.close

    segments_input.map do |segment_input|
      point1_input, point2_input = segment_input.split(' -> ')
      point1 = Square.new(*point1_input.split(',').map(&:to_i))
      point2 = Square.new(*point2_input.split(',').map(&:to_i))
      Segment.new(point1, point2)
    end
  end
end
