class PizzaBot
  attr_reader :max_grid_dimensions

  def initialize(options)
    @bot_position = { x: 0, y: 0 }
    @moves = { x: %w(W E), y: %w(S N) }
    @instructions = String.new
    @deliveries = []

    parse_options(options)
    validate_delivery_locations
  end

  def deliver!
    @deliveries.each do |house|
      move_to(house)
      drop_pizza
    end
    @instructions
  end

  private def parse_options(options)
    arguments = options[0].tr('(),', ' ').split(' ')
    max_grid_dimensions = arguments.shift.split('x').map!(&:to_i)
    max_grid_dimensions = { x: max_grid_dimensions.first, y: max_grid_dimensions.last }

    arguments.map!(&:to_i).each_slice(2) do |house_position|
      @deliveries << House.new(*house_position, max_grid_dimensions)
    end
  end

  private def validate_delivery_locations
    raise StandardError.new("House out of the grid") if @deliveries.any?(&:outside_of_grid?)
  end

  private def move_to(house)
    determine_moves_to(house)
    @bot_position = house.position
  end

  private def determine_moves_to(house)
    [:x, :y].each do |axis|
      distance = house[axis] - @bot_position[axis]
      move = distance < 0 ? @moves[axis].first : @moves[axis].last
      @instructions.concat(move * distance.abs)
    end
  end

  private def drop_pizza
    @instructions.concat('D')
  end
end