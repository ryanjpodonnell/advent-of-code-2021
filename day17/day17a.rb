TargetArea = Struct.new(:min_x, :max_x, :min_y, :max_y)
Velocity = Struct.new(:x, :y)
Position = Struct.new(:x, :y)
Trajectory = Struct.new(:path, :lands_in_target_area)

module Day17a
  def solution(filename)
    @target_area = parse_input(filename)
    trajectory = fastest_trajectory.path.map(&:y).max
  end

  def fastest_trajectory
    max_x_velocity = @target_area.max_x
    max_y_velocity = @target_area.min_y.abs - 1

    (0..max_y_velocity).to_a.reverse.each do |y|
      (0..max_x_velocity).to_a.reverse.each do |x|
        position = Position.new(0, 0)
        velocity = Velocity.new(x, y)
        trajectory = calculate_trajectory(position, velocity)
        return trajectory if trajectory.lands_in_target_area
      end
    end
  end

  def calculate_trajectory(position, velocity)
    @trajectory = []
    step(position, velocity)
    lands_in_target_area = in_target_area(@trajectory.last)

    Trajectory.new(@trajectory.dup, lands_in_target_area)
  end

  def step(position, velocity)
    return if position.x > @target_area.max_x || position.y < @target_area.min_y
    return if in_target_area(position)

    @trajectory << position
    position.x += velocity.x
    velocity.x -= 1 if velocity.x.positive?
    velocity.x += 1 if velocity.x.negative?
    position.y += velocity.y
    velocity.y -= 1

    new_position = Position.new(position.x, position.y)
    new_velocity = Velocity.new(velocity.x, velocity.y)
    step(new_position, new_velocity)
  end

  def in_target_area(position)
    position.x >= @target_area.min_x &&
      position.x <= @target_area.max_x &&
      position.y >= @target_area.min_y &&
      position.y <= @target_area.max_y
  end

  def parse_input(filename)
    input = File.read(filename).chomp[13..-1]
    x_bounds, y_bounds = input.split(', ').map { |i| i[2..-1] }
    min_x, max_x = x_bounds.split('..').map(&:to_i)
    min_y, max_y = y_bounds.split('..').map(&:to_i)
    TargetArea.new(min_x, max_x, min_y, max_y)
  end
end
