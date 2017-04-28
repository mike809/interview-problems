require 'rails_helper'

RSpec.describe PizzaBot, type: :model do
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
        expect(bot.deliver!).to eq simple_output
      end
    end

    describe 'when called with a complex input' do
      let(:input) { complex_input }

      it 'matches the expected output' do
        expect(bot.deliver!).to eq complex_output
      end
    end

    describe 'when called with an asymmetrical grid input' do
      let(:input) { asymmetrical_input }

      it 'matches the expected output' do
        expect(bot.deliver!).to eq asymmetrical_output
      end
    end

    describe 'when called with an invalid input' do
      let(:input) { invalid_input }

      it 'matches the expected output' do
        expect{ bot.deliver! }.to raise_error StandardError
      end
    end
  end
end