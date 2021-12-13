require 'rspec'
require './day13a.rb'

RSpec.describe Day13a do
  include Day13a

  let(:example_filename) { 'example.txt' }
  let(:input_filename) { 'input.txt' }

  it 'returns the expect solution' do
    expect(solution(example_filename)).to eq(17)
    expect(solution(input_filename)).to eq(669)
  end
end
