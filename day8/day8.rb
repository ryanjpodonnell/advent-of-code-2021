class Parser
  def initialize(signal_pattern, output_value)
    @signal_pattern = signal_pattern.map { |pattern| pattern.split('').sort.join }
    @output_value = output_value.map { |pattern| pattern.split('').sort.join }
    @legend = {}
    parse!
  end

  def parse!
    remaining_digits = @signal_pattern

    one = remaining_digits.select { |pattern| pattern.length == 2 }.first
    @legend[one] = 1
    remaining_digits = (remaining_digits - [one])

    four = remaining_digits.select { |pattern| pattern.length == 4 }.first
    @legend[four] = 4
    remaining_digits = (remaining_digits - [four])

    seven = remaining_digits.select { |pattern| pattern.length == 3 }.first
    @legend[seven] = 7
    remaining_digits = (remaining_digits - [seven])

    eight = remaining_digits.select { |pattern| pattern.length == 7 }.first
    @legend[eight] = 8
    remaining_digits = (remaining_digits - [eight])

    three = remaining_digits.select do |pattern|
      pattern.length == 5 && (pattern.split('') - seven.split('')).count == 2
    end.first
    @legend[three] = 3
    remaining_digits = (remaining_digits - [three])

    nine = remaining_digits.select do |pattern|
      pattern.length == 6 && (pattern.split('') - three.split('')).count == 1
    end.first
    @legend[nine] = 9
    remaining_digits = (remaining_digits - [nine])

    five = remaining_digits.select do |pattern|
      pattern.length == 5 && (nine.split('') - pattern.split('')).count == 1
    end.first
    @legend[five] = 5
    remaining_digits = (remaining_digits - [five])

    two = remaining_digits.select { |pattern| pattern.length == 5 }.first
    @legend[two] = 2
    remaining_digits = (remaining_digits - [two])

    six = remaining_digits.select do |pattern|
      pattern.length == 6 && (pattern.split('') - one.split('')).count == 5
    end.first
    @legend[six] = 6
    remaining_digits = (remaining_digits - [six])

    @legend[remaining_digits.first] = 0
  end

  def score
    @output_value.map { |value| @legend[value] }.join.to_i
  end
end

module Day8
  def part1(filename)
    _, output_values = parse_input(filename)
    output_values.map do |output_value|
      output_value.select do |digit|
        digit.length == 2 ||
          digit.length == 3 ||
          digit.length == 4 ||
          digit.length == 7
      end.count
    end.sum
  end

  def part2(filename)
    signal_patterns, output_values = parse_input(filename)

    signal_patterns.each_with_index.map do |pattern, i|
      Parser.new(pattern, output_values[i]).score
    end.sum
  end

  def parse_input(filename)
    file = File.open(filename)
    lines = file.readlines.map(&:chomp)
    file.close

    signal_patterns = lines
                      .map { |line| line.split(' | ').first }
                      .map { |line| line.split(' ') }
    output_values = lines
                    .map { |line| line.split(' | ').last }
                    .map { |line| line.split(' ') }

    [signal_patterns, output_values]
  end
end

include Day8
puts part1('input_example.txt')
puts part1('input.txt')
puts part2('input_example.txt')
puts part2('input.txt')
