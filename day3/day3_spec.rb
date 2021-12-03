require 'rspec'
require './day3.rb'

RSpec.describe Day3 do
  include Day3

  let(:filename) { 'input_example.txt' }

  it 'returns the expect solution' do
    expect(part_1(filename)).to eq(198)
    expect(part_2(filename)).to eq(230)
  end
end
