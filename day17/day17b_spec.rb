require 'rspec'
require './day17b.rb'

RSpec.describe Day17b do
  include Day17b

  let(:example_filename) { 'example.txt' }
  let(:input_filename) { 'input.txt' }

  it 'returns the expect solution' do
    expect(solution(example_filename)).to eq(112)
    expect(solution(input_filename)).to eq(3528)
  end
end
