require 'rails_helper'

describe 'CleanCart' do
  describe '#call' do

    context 'clean existing cart' do
      let(:full_cart) { create(:cart, :full_cart) }
      subject(:result) { CleanCart.new.call(cart: full_cart) }

      it 'returns success' do
        expect(result.success?).to eq true
      end

      it 'destroys all cart_items' do
        cart_items = result.success.items
        
        expect(cart_items.count).to eq 0
      end
    end
  end
end
