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
  def initialize(octopi)
    @octopi = octopi
  end

  def step
    raise_octopi_energy_levels
    flash_octopi
    return true if check_for_simultaneous_flashes

    reset_octopi
    nil
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

  def check_for_simultaneous_flashes
    @octopi.flatten.all?(&:flashed_this_step)
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

module Day11b
  def solution(filename)
    lines = parse_input(filename)
    octopi = lines.each_with_index.map do |line, row|
      energy_levels = line.split('').map(&:to_i)
      energy_levels.each_with_index.map do |energy_level, column|
        Octopus.new(energy_level, row, column)
      end
    end

    grid = Grid.new(octopi)

    iteration = 0
    loop do
      simultaneous_flashes = grid.step
      iteration += 1
      return iteration if simultaneous_flashes == true
    end
  end

  def parse_input(filename)
    File.read(filename).split("\n")
  end
end
