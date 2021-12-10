class SyntaxParser
  OPEN = ['(', '[', '{', '<'].freeze

  MAPPING = {
    '(' => ')',
    '[' => ']',
    '{' => '}',
    '<' => '>'
  }.freeze

  SCORE = {
    ')' => 3,
    ']' => 57,
    '}' => 1_197,
    '>' => 25_137
  }.freeze

  SCORE2 = {
    ')' => 1,
    ']' => 2,
    '}' => 3,
    '>' => 4
  }.freeze

  def initialize
    @occurances = {
      ')' => 0,
      ']' => 0,
      '}' => 0,
      '>' => 0
    }
    @closing_sequences = []
  end

  def score
    @occurances.map do |char, number_of_occurances|
      number_of_occurances * SCORE[char]
    end.sum
  end

  def score2
    sorted_scores = @closing_sequences.map do |sequence|
      score_sequence(sequence)
    end.sort

    sorted_scores.at(sorted_scores.length / 2)
  end

  def score_sequence(sequence)
    score = 0

    sequence.each do |char|
      score *= 5
      score += SCORE2[char]
    end

    score
  end

  def parse_chunk(chunk)
    stack = []
    valid_chunk = true

    chunk.chars.each do |char|
      if OPEN.include?(char)
        stack = stack.push(char)
      else
        popped_char = stack.pop
        if char != MAPPING[popped_char]
          @occurances[char] += 1 if char != MAPPING[popped_char]
          valid_chunk = false
        end
      end
    end

    @closing_sequences << stack.map { |char| MAPPING[char] }.reverse if valid_chunk
  end
end

module Day10
  def part1(filename)
    parser = SyntaxParser.new
    chunks = parse_input(filename)
    chunks.each do |chunk|
      parser.parse_chunk(chunk)
    end

    parser.score
  end

  def part2(filename)
    parser = SyntaxParser.new
    chunks = parse_input(filename)
    chunks.each do |chunk|
      parser.parse_chunk(chunk)
    end

    parser.score2
  end

  def parse_input(filename)
    file = File.open(filename)
    input = file.readlines.map(&:chomp)
    file.close
    input
  end
end
