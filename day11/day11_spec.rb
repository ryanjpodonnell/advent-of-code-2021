require 'rspec'
# require './day11a.rb'
require './day11b.rb'

# RSpec.describe Day11a do
#   include Day11a

#   let(:example_filename) { 'example.txt' }
#   let(:input_filename) { 'input.txt' }

#   it 'returns the expect solution' do
#     expect(solution_a(example_filename)).to eq(1656)
#     expect(solution_a(input_filename)).to eq(1562)
#   end
# end

RSpec.describe Day11b do
  include Day11b

  let(:example_filename) { 'example.txt' }
  let(:input_filename) { 'input.txt' }

  it 'returns the expect solution' do
    expect(solution(example_filename)).to eq(195)
    expect(solution(input_filename)).to eq(268)
  end
end
