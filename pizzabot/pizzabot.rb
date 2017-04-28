#!/usr/bin/env ruby

require "minitest/autorun"
require "pry"

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

describe House do
  describe '#outside_of_grid?' do
    let(:house_params) { [4, 5, { x: 5, y: 6 }] }
    let(:house) { House.new(*house_params) }

    describe 'with a valid house' do
      it 'is not outside of the grid' do
        house.outside_of_grid?.must_equal false
      end
    end

    describe 'with an invalid house' do
      let(:house_params) { [4, 5, { x: 5, y: 5 }] }
      it 'is outside of the grid' do
        house.outside_of_grid?.must_equal true
      end
    end
  end
end

describe PizzaBot do
  describe '#deliver' do
    let(:simple_input) { ['5x5 (1, 3) (4, 4)'] }
    let(:invalid_input) { ['5x5 (1, 3) (4, 5)'] }
    let(:asymmetrical_input) { ['5x6 (1, 3) (4, 5)'] }
    let(:complex_input) { ['5x5 (0, 0) (1, 3) (4, 4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)'] }

    let(:asymmetrical_output) { 'ENNNDEEENND' }
    let(:simple_output) { 'ENNNDEEEND' }
    let(:complex_output) { 'DENNNDEEENDSSDDWWWWSDEEENDWNDEESSD' }

    let(:bot) { PizzaBot.new(input) }

    describe 'when called with a simple input' do
      let(:input) { simple_input }

      it 'matches the expected output' do
        bot.deliver!.must_equal simple_output
      end
    end

    describe 'when called with a complex input' do
      let(:input) { complex_input }

      it 'matches the expected output' do
        bot.deliver!.must_equal complex_output
      end
    end

    describe 'when called with an asymmetrical grid input' do
      let(:input) { asymmetrical_input }

      it 'matches the expected output' do
        bot.deliver!.must_equal asymmetrical_output
      end
    end

    describe 'when called with an invalid input' do
      let(:input) { invalid_input }

      it 'matches the expected output' do
        -> { bot.deliver! }.must_raise StandardError
      end
    end
  end
end