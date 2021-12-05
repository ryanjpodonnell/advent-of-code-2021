require 'rspec'
require './day4.rb'

RSpec.describe Day4 do
  include Day4

  let(:filename) { 'input_example.txt' }

  it 'returns the expect solution' do
    expect(part_1(filename)).to eq(4512)
    expect(part_2(filename)).to eq(1924)
  end
end
