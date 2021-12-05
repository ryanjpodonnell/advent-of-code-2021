Square = Struct.new(:value, :row, :column, :marked)

class Board
  attr_reader :winning_number
  attr_accessor :place

  def initialize(rows)
    @rows = rows
    @squares = []
    @most_recently_marked_number = nil
    @winning_place = nil
    parse_input!
  end

  def mark!(number)
    @squares.select { |square| square.value == number }.each do |square|
      @most_recently_marked_number = number
      square.marked = true
    end
  end

  def victory?
    (0..4).each do |row_or_column_count|
      row_marked_count = marked_count(:row, row_or_column_count)
      column_marked_count = marked_count(:column, row_or_column_count)

      if row_marked_count == 5 || column_marked_count == 5
        @winning_number = @most_recently_marked_number
        return true
      end
    end

    false
  end

  def marked_count(method, row_or_column_count)
    @squares
      .select { |square| square.send(method) == row_or_column_count }
      .select { |square| square.marked == true }
      .count
  end

  def sum_of_all_unmarked_numbers
    @squares.select { |square| square.marked == false }.map(&:value).sum
  end

  def score
    sum_of_all_unmarked_numbers * winning_number
  end

  def parse_input!
    @rows.each_with_index do |row, row_index|
      row.each_with_index do |value, column_index|
        @squares << Square.new(value, row_index, column_index, false)
      end
    end
  end
end

module Day4
  def part_1(filename)
    order, boards = parse_input(filename)

    order.each do |number|
      boards.each { |board| board.mark!(number) }
      boards.each do |board|
        return board.score if board.victory?
      end
    end
  end

  def part_2(filename)
    order, boards = parse_input(filename)
    place = 1

    order.each do |number|
      boards.each { |board| board.mark!(number) if board.victory? == false }
      boards.each do |board|
        if board.victory? && board.place.nil?
          board.place = place
          place += 1
        end
      end
    end

    boards.max_by(&:place).score
  end

  def parse_input(filename)
    file = File.open(filename)
    order = file.gets.split(',').map(&:to_i)
    boards = []

    while file.eof? == false
      file.gets

      board_input = 5.times.map { |_| file.gets.split(' ').map(&:to_i) }
      boards << Board.new(board_input)
    end

    file.close

    [order, boards]
  end
end
