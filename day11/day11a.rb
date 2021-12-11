# frozen_string_literal: true

class Octopus
  attr_accessor :energy_level, :flashed_this_step

  def initialize(energy_level, row, column)
    @energy_level = energy_level
    @row = row
    @column = column
    @flashed_this_step = false
  end

  def raise_energy_level
    @energy_level += 1
  end

  def neighboring_positions
    [
      [@row - 1, @column - 1],
      [@row - 1, @column],
      [@row - 1, @column + 1],
      [@row, @column - 1],
      [@row, @column + 1],
      [@row + 1, @column - 1],
      [@row + 1, @column],
      [@row + 1, @column + 1]
    ].select { |r, c| r >= 0 && r < 10 && c >= 0 && c < 10 }
  end
end

class Grid
  attr_accessor :number_of_flashes

  def initialize(octopi)
    @octopi = octopi
    @number_of_flashes = 0
  end

  def step
    raise_octopi_energy_levels
    flash_octopi
    count_flashes
    reset_octopi
  end

  def raise_octopi_energy_levels
    @octopi.flatten.each(&:raise_energy_level)
  end

  def flash_octopi
    @octopi.flatten.each do |octopus|
      flash(octopus) if octopus.energy_level > 9 && octopus.flashed_this_step == false
    end
  end

  def flash(octopus)
    octopus.flashed_this_step = true
    octopus.neighboring_positions.each do |row, column|
      @octopi[row][column].raise_energy_level
      if @octopi[row][column].energy_level > 9 && @octopi[row][column].flashed_this_step == false
        flash(@octopi[row][column])
      end
    end
  end

  def count_flashes
    @octopi.flatten.each do |octopus|
      @number_of_flashes += 1 if octopus.flashed_this_step == true
    end
  end

  def reset_octopi
    @octopi.flatten.each do |octopus|
      if octopus.flashed_this_step == true
        octopus.flashed_this_step = false
        octopus.energy_level = 0
      end
    end
  end
end

module Day11a
  def solution_a(filename)
    lines = parse_input(filename)
    octopi = lines.each_with_index.map do |line, row|
      energy_levels = line.split('').map(&:to_i)
      energy_levels.each_with_index.map do |energy_level, column|
        Octopus.new(energy_level, row, column)
      end
    end

    grid = Grid.new(octopi)

    100.times do
      grid.step
    end

    grid.number_of_flashes
  end

  def parse_input(filename)
    File.read(filename).split("\n")
  end
end
