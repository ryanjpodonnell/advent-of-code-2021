require 'rspec'
require './day9.rb'

RSpec.describe Day9 do
  include Day9

  let(:example_filename) { 'input_example.txt' }
  let(:input_filename) { 'input.txt' }

  it 'returns the expect solution' do
    expect(part1(example_filename)).to eq(15)
    expect(part1(input_filename)).to eq(591)
    expect(part2(example_filename)).to eq(1_134)
    expect(part2(input_filename)).to eq(1_113_424)
  end
end
