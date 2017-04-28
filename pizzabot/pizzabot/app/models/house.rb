class House
  attr_reader :position

  def initialize(x, y, max_grid_dimensions)
    @position = { x: x, y: y }
    @max_grid_dimensions = max_grid_dimensions
  end

  def [](axis)
    @position[axis]
  end

  def outside_of_grid?
    [:x, :y].any? do |axis|
      @position[axis] < 0 || @position[axis] >= @max_grid_dimensions[axis]
    end
  end
end