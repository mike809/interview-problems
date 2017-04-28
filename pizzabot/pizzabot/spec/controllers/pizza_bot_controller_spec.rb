require 'rails_helper'

    # let(:simple_input) { ['5x5 (1, 3) (4, 4)'] }
    # let(:invalid_input) { ['5x5 (1, 3) (4, 5)'] }
    # let(:asymmetrical_input) { ['5x6 (1, 3) (4, 5)'] }
    # let(:complex_input) { ['5x5 (0, 0) (1, 3) (4, 4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)'] }

#     let(:asymmetrical_output) { 'ENNNDEEENND' }
#     let(:simple_output) { 'ENNNDEEEND' }
#     let(:complex_output) { 'DENNNDEEENDSSDDWWWWSDEEENDWNDEESSD' }

#     let(:bot) { PizzaBot.new(input) }

#     describe 'when called with a simple input' do
#       let(:input) { simple_input }

#       it 'matches the expected output' do
#         bot.deliver!.must_equal simple_output
#       end
#     end

#     describe 'when called with a complex input' do
#       let(:input) { complex_input }

#       it 'matches the expected output' do
#         bot.deliver!.must_equal complex_output
#       end
#     end

#     describe 'when called with an asymmetrical grid input' do
#       let(:input) { asymmetrical_input }

#       it 'matches the expected output' do
#         bot.deliver!.must_equal asymmetrical_output
#       end
#     end

#     describe 'when called with an invalid input' do
#       let(:input) { invalid_input }

#       it 'matches the expected output' do
#         -> { bot.deliver! }.must_raise StandardError
#       end
#     end
#   end

RSpec.describe PizzaBotController, type: :controller do
  let(:simple_input) { '5x5 (1, 3) (4, 4)' }
  let(:invalid_input) { '5x5 (1, 3) (4, 5)' }
  let(:asymmetrical_input) { '5x6 (1, 3) (4, 5)' }
  let(:complex_input) { '5x5 (0, 0) (1, 3) (4, 4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)' }

  let(:asymmetrical_output) { 'ENNNDEEENND' }
  let(:simple_output) { 'ENNNDEEEND' }
  let(:complex_output) { 'DENNNDEEENDSSDDWWWWSDEEENDWNDEESSD' }

  subject(:pizzabot) do 
    post :create, input: input
  end

  context 'when we get a new request' do  
    let(:input) { simple_input } 
    it 'sends 200 response' do
      expect(subject).to have_http_status(200)
    end
  end

  context 'when we send a simple input' do
    let(:input) { simple_input  }
    
    it 'responds with the simple output' do 
      expect(subject.body).to eq(simple_output)
    end
  end
end
