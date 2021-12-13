require 'rspec'
require './day14a.rb'

RSpec.describe Day14a do
  include Day14a

  let(:example_filename) { 'example.txt' }
  let(:input_filename) { 'input.txt' }

  it 'returns the expect solution' do
    expect(solution(example_filename)).to eq(17)
    expect(solution(input_filename)).to eq(669)
  end
end
