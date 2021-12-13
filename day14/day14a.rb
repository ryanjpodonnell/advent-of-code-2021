require 'set'

module Day14a
  def solution(filename)
    instructions = parse_input(filename)
  end

  def parse_input(filename)
    file = File.open(filename)
    input = file.readlines.map(&:chomp)
    file.close

    input
  end
end
