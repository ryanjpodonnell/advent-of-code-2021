require 'rspec'
require './day14b.rb'

RSpec.describe Day14b do
  include Day14b

  let(:example_filename) { 'example.txt' }
  let(:input_filename) { 'input.txt' }

  it 'returns the expect solution' do
    expect(solution(example_filename)).to eq(16)
    expect(solution(input_filename)).to eq(90)
  end
end
