require 'rails_helper'

describe UpdateCart do
  describe '#call' do
    let(:cart) { create(:cart, :cart_with_products) }
    let(:first_item) { cart.items.first }
    let(:second_item) { cart.items.second }
    let(:first_product_id) { cart.items.first.product_id }

    let(:cart_items) do
      {
        first_item.id => { quantity: quantity },
        second_item.id => { quantity: quantity }
      }
    end

    subject(:result) { described_class.new.call(cart: cart, items_after_update: cart_items) }

    context 'cart has <10 cart items' do
      context 'all new quantities are correct' do
        let(:quantity) { 2 }

        it 'returns success' do
          expect(result.success?).to eq true
        end

        it 'updates cart items quantity' do
          quantities = result.success.items.map(&:quantity)

          expect(quantities.all? { |q| q == 2 }).to eq true
        end

        it 'updates cart items final price' do
          final_prices = result.success.items.map(&:final_price_cents)

          expect(final_prices.all? { |p| p == 2000 }).to eq true
        end
      end

      context 'new quantities are not correct' do
        let(:quantity) { 6 }

        it 'returns failure' do
          expect(result.failure?).to eq true
        end

        it 'returns error message' do
          expect(result.failure[:message]).to eq 'Maximum quantity exceeded (you cannot add more then 5 items)'
        end
      end
    end
  end
end
