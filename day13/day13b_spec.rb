require 'rspec'
require './day13b.rb'

RSpec.describe Day13b do
  include Day13b

  let(:example_filename) { 'example.txt' }
  let(:input_filename) { 'input.txt' }

  it 'returns the expect solution' do
    expect(solution(example_filename)).to eq(16)
    expect(solution(input_filename)).to eq(90)
  end
end
