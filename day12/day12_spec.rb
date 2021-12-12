require 'rspec'
# require './day12a.rb'
require './day12b.rb'

# RSpec.describe Day12a do
#   include Day12a

#   let(:example_filename) { 'example.txt' }
#   let(:example2_filename) { 'example2.txt' }
#   let(:example3_filename) { 'example3.txt' }
#   let(:input_filename) { 'input.txt' }

#   it 'returns the expect solution' do
#     expect(solution_a(example_filename)).to eq(10)
#     expect(solution_a(example2_filename)).to eq(19)
#     expect(solution_a(example3_filename)).to eq(226)
#     expect(solution_a(input_filename)).to eq(3563)
#   end
# end

RSpec.describe Day12b do
  include Day12b

  let(:example_filename) { 'example.txt' }
  let(:example2_filename) { 'example2.txt' }
  let(:example3_filename) { 'example3.txt' }
  let(:input_filename) { 'input.txt' }

  it 'returns the expect solution' do
    expect(solution_b(example_filename)).to eq(36)
    expect(solution_b(example2_filename)).to eq(103)
    expect(solution_b(example3_filename)).to eq(3_509)
    expect(solution_b(input_filename)).to eq(105_453)
  end
end
