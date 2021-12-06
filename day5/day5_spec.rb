require 'rspec'
require './day5.rb'

RSpec.describe Day5 do
  include Day5

  let(:filename) { 'input_example.txt' }

  it 'returns the expect solution' do
    expect(part_1(filename)).to eq(5)
    expect(part_2(filename)).to eq(12)
  end
end
