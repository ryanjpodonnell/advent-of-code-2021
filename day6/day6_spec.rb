require 'rspec'
require './day6.rb'

RSpec.describe Day6 do
  include Day6

  let(:filename) { 'input_example.txt' }

  it 'returns the expect solution' do
    expect(part1(filename, 18)).to eq(26)
    expect(part1(filename, 80)).to eq(5_934)
    expect(part1(filename, 256)).to eq(26_984_457_539)
  end
end
