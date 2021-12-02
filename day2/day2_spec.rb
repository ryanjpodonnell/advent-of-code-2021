require 'rspec'
require './day2.rb'

RSpec.describe Day2 do
  include Day2

  let(:filename) { 'input.txt' }

  it 'returns the expect solution' do
    expect(solution(filename)).to eq(1_741_971_043)
  end
end
