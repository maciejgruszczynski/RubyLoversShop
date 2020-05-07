require 'rails_helper'

describe CleanCart do
  describe '#call' do

    context 'clean existing cart' do
      let(:full_cart) { create(:cart, :full_cart) }
      subject(:result) { described_class.new.call(cart: full_cart) }

      it 'returns cart' do
        expect(result).to eq full_cart
      end

      it 'destroys all cart_items' do
        cart_items = result.items

        expect(cart_items.count).to eq 0
      end
    end
  end
end
