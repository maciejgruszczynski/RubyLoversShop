require 'rails_helper'

describe 'CreateTempCart' do
  describe '#call' do

    context 'no cart defined' do
      subject(:result) { CreateTempCart.new.call }

      it 'returns Success' do
        expect(result.success?).to eq true
      end

      it 'creates temporary cart' do
        cart = result.success[:cart]

        expect(cart.new_record?).to eq true
      end

      it 'creates cart identifier' do
        cart = result.success[:cart]

        expect(cart.identifier.present?).to eq true
      end
    end
  end
end
