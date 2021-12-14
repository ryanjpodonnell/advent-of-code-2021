module Day14a
  def solution(filename)
    @filename = filename
    @polymer_template, @pair_insertions = parse_input
    @final_string = ''

    final_string = ''
    10.times do
      final_string = step
    end

    counts = Hash.new(0)
    final_string.split('').each do |char|
      counts[char] += 1
    end

    counts = counts.sort_by {|k, v| v}
    counts.last.last - counts.first.last
  end

  def step
    starting_string = @polymer_template.dup

    insert_point = 1
    starting_string.split('').each_cons(2) do |a, b|
      insert_char = @pair_insertions["#{a}#{b}"]
      @polymer_template.insert(insert_point, insert_char)
      insert_point += 2
    end

    @polymer_template
  end

  def parse_input
    file = File.open(@filename)
    polymer_template = file.gets.chomp
    pair_insertions = {}
    file.gets

    while file.eof? == false
      input = file.gets.chomp
      ab, c = input.split(' -> ')
      pair_insertions[ab] = c
    end

    file.close

    [polymer_template, pair_insertions]
  end
end
