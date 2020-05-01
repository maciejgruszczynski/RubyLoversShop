require 'rails_helper'

describe 'UpdateProduct' do
  describe '#call' do
    let(:cart) { create(:cart, :cart_with_products) }
    let(:product_id) {cart.items.first.product_id}

    subject(:result) { UpdateProduct.new.call(cart: cart, product_id: product_id, quantity: quantity) }


    describe 'cart with products' do
      context 'final quantity <= 5' do
        let(:quantity) { 4 }

        it 'returns true' do
          expect(result.success?).to eq true
        end

        it 'updates item quantity' do
          quantity = result.success.items.first.quantity

          expect(quantity).to eq 5
        end

        it 'updates item final price' do
          final_price = result.success.items.first.final_price_cents

          expect(final_price).to eq 5000
        end
      end

      context 'final quantity > 5' do
        let(:quantity) { 6 }

        it 'returns false' do
          expect(result.failure?).to eq true
        end

        it 'returns error message' do
          expect(result.failure[:message]).to eq 'Maximum quantity exceeded (you cannot add more then 5 items)'
        end
      end
    end
  end
end
