class PizzaBotController < ApplicationController
    def create
      pizzabot_input = params[:input]
      pizzabot = PizzaBot.new([pizzabot_input])
      result = pizzabot.deliver!
      render plain: result
    end
end
