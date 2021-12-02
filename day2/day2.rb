Instruction = Struct.new(:command, :units)

class Submarine
  attr_accessor :horizontal_position, :depth

  def initialize(horizontal_position, depth, aim)
    @horizontal_position = horizontal_position
    @depth = depth
    @aim = aim
  end

  def dive!(instructions)
    instructions.each do |instruction|
      handle_instruction!(instruction)
    end
  end

  def code
    @horizontal_position * @depth
  end

  private

  def handle_instruction!(instruction)
    units = instruction.units

    case instruction.command
    when :forward
      @horizontal_position += units
      @depth += (@aim * units)
    when :down
      @aim += units
    when :up
      @aim -= units
    end
  end
end

module Day2
  def solution(filename)
    instructions = parse_input(filename)
    submarine = Submarine.new(0, 0, 0)
    submarine.dive!(instructions)
    submarine.code
  end

  def parse_input(filename)
    file_data = File.open(filename)
    file_data.readlines.map do |line|
      line.chomp!
      command = line.split(' ').first.to_sym
      units = line.split(' ').last.to_i
      Instruction.new(command, units)
    end
  end
end
