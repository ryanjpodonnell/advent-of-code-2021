require 'set'

module Day13a
  def solution(filename)
    coords_input, instructions = parse_input(filename)

    @coords = Set.new
    coords_input.each do |coord_input|
      @coords.add(coord_input)
    end

    instructions.each do |axis, line|
      fold_along_x(line) if axis == 'x'
      fold_along_y(line) if axis == 'y'
      break
    end

    @coords.length
  end

  def fold_along_x(line)
    @coords.dup.each do |x, y|
      next unless x > line

      @coords.delete([x, y])
      distance = (x - line) * 2
      @coords.add([x - distance, y])
    end
  end

  def fold_along_y(line)
    @coords.dup.each do |x, y|
      next unless y > line

      @coords.delete([x, y])
      distance = (y - line) * 2
      @coords.add([x, y - distance])
    end
  end

  def parse_input(filename)
    file = File.open(filename)
    input = file.readlines.map(&:chomp)
    file.close

    coords = []
    instructions = []
    coords_finished = false

    input.each do |line|
      if line == ''
        coords_finished = true
        next
      end

      if coords_finished == false
        x, y = line.split(',')
        coords << [x.to_i, y.to_i]
      else
        axis, number = line[11..-1].split('=')
        instructions << [axis, number.to_i]
      end
    end

    [coords, instructions]
  end
end
