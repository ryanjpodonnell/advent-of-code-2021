require 'rspec'
require './day10.rb'

RSpec.describe Day10 do
  include Day10

  let(:filename) { 'input_example.txt' }

  it 'returns the expect solution' do
    expect(part1(filename)).to eq(37)
    expect(part2(filename)).to eq(168)
  end
end
