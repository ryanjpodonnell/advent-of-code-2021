require 'rspec'
require './day15zz.rb'

RSpec.describe Day15zz do
  include Day15zz

  let(:example_filename) { 'example.txt' }
  let(:input_filename) { 'input.txt' }

  it 'returns the expect solution' do
    expect(solution(example_filename)).to eq(315)
    expect(solution(input_filename)).to eq(2853)
  end
end
