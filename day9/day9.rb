class Square
  attr_reader :value, :row, :column, :neighboring_positions

  def initialize(value, row, column, neighboring_positions = [])
    @value = value
    @row = row
    @column = column
    @neighboring_positions = neighboring_positions
  end

  def low_point(master_array)
    @value < neighbors(master_array).map(&:value).min
  end

  def risk_level(master_array)
    @value + 1 if low_point(master_array)
  end

  def neighbors(master_array)
    neighboring_positions.map { |row, column| master_array[row][column] }
  end
end

module Day9
  def part1(filename)
    master_array = parse_input(filename)

    master_array.flatten.map { |square| square.risk_level(master_array) }.compact.sum
  end

  def part2(filename)
    master_array = parse_input(filename)
    low_points = master_array.flatten.select { |square| square.low_point(master_array) }
    low_points.map do |square|
      @test = 1
      @explored_positions = [square.row, square.column]
      basin_size(square, master_array)

      @explored_positions = []
      @test
    end.sort.reverse.first(3).inject(:*)
  end

  def basin_size(low_point, master_array)
    low_point.neighbors(master_array).each do |square|
      coords = [square.row, square.column]
      next unless square.value > low_point.value &&
                  square.value < 9 &&
                  !@explored_positions.include?(coords)

      @test += 1
      @explored_positions << [square.row, square.column]

      basin_size(square, master_array)
    end
  end

  def parse_input(filename)
    file = File.open(filename)
    input = file.readlines.map(&:chomp)
    file.close

    lines = input.map { |line| line.split('').map(&:to_i) }
    maximum_row = lines.length
    maximum_column = lines.first.length

    master_array = lines.each_with_index.map do |line, row|
      line.each_with_index.map do |value, column|
        neighbors_matrix = [
          [-1, 0],
          [0, -1],
          [0, 1],
          [1, 0]
        ]

        all_neighboring_positions = neighbors_matrix.map do |row_adjustment, column_adjustment|
          [row + row_adjustment, column + column_adjustment]
        end
        neighboring_positions = all_neighboring_positions.select do |neighboring_row, neighboring_column|
          neighboring_row >= 0 &&
            neighboring_row < maximum_row &&
            neighboring_column >= 0 &&
            neighboring_column < maximum_column
        end

        Square.new(value, row, column, neighboring_positions)
      end
    end

    master_array
  end
end
