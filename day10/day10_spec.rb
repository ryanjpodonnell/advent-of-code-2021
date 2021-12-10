require 'rspec'
require './day10.rb'

RSpec.describe Day10 do
  include Day10

  let(:example_filename) { 'example.txt' }
  let(:input_filename) { 'input.txt' }

  it 'returns the expect solution' do
    expect(part1(example_filename)).to eq(26_397)
    expect(part1(input_filename)).to eq(366_027)
    expect(part2(example_filename)).to eq(288_957)
    expect(part2(input_filename)).to eq(1_118_645_287)
  end
end
