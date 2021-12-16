require 'rspec'
require './day16a.rb'

RSpec.describe Day16a do
  include Day16a

  let(:example_filename) { 'example.txt' }
  let(:input_filename) { 'input.txt' }

  it 'returns the expect solution' do
    expect(solution(example_filename)).to eq(2021)
    expect(solution(input_filename)).to eq(2_223_947_372_407)
  end
end
