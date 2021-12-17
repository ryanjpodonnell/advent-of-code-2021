require 'rspec'
require './day17a.rb'

RSpec.describe Day17a do
  include Day17a

  let(:example_filename) { 'example.txt' }
  let(:input_filename) { 'input.txt' }

  it 'returns the expect solution' do
    expect(solution(example_filename)).to eq(45)
    expect(solution(input_filename)).to eq(12_246)
  end
end
