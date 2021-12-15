require 'rspec'
require './day15z.rb'

RSpec.describe Day15z do
  include Day15z

  let(:example_filename) { 'example.txt' }
  let(:input_filename) { 'input.txt' }

  it 'returns the expect solution' do
    expect(solution(example_filename)).to eq(40)
    expect(solution(input_filename)).to eq(503)
  end
end
