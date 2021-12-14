class Polymer
  attr_accessor :results, :count, :new_count, :significant_char

  def initialize(pair, char)
    @results = ["#{pair[0]}#{char}", "#{char}#{pair[1]}"]
    @significant_char = pair[0]
    @count = 0
    @new_count = 0
  end
end

module Day14b
  def solution(filename)
    polymer_template, pair_insertions = parse_input(filename)
    map = initialize_map(polymer_template, pair_insertions)

    40.times do
      step(pair_insertions, map)
    end

    counts = sorted_counts(map, polymer_template[-1])
    counts.last.last - counts.first.last
  end

  def initialize_map(polymer_template, pair_insertions)
    map = {}

    pair_insertions.each do |pair, char|
      map[pair] = Polymer.new(pair, char)
    end

    polymer_template.split('').each_cons(2) do |pair|
      map[pair.join('')].count += 1
    end

    map
  end

  def step(pair_insertions, map)
    map.values.each do |polymer|
      results = polymer.results
      map[results.first].new_count += polymer.count
      map[results.last].new_count += polymer.count
    end

    map.values.each do |polymer|
      polymer.count = polymer.new_count
      polymer.new_count = 0
    end
  end

  def sorted_counts(map, last_character)
    counts = Hash.new(0)
    map.values.each do |polymer|
      counts[polymer.significant_char] += polymer.count
    end
    counts[last_character] += 1
    counts.sort_by { |_, v| v }
  end

  def parse_input(filename)
    file = File.open(filename)
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
