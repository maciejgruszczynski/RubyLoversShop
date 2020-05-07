require 'rails_helper'

describe CreateTempCart do
  describe '#call' do

    context 'no cart defined' do
      subject(:result) { described_class.new.call }

      it 'creates temporary cart' do
        cart = result

        expect(cart.new_record?).to eq true
      end

      it 'creates cart identifier' do
        cart = result

        expect(cart.identifier.present?).to eq true
      end
    end
  end
end
