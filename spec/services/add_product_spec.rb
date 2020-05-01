require 'rails_helper'

describe 'AddProduct' do
  describe '#call' do
    let(:cart) { create(:cart) }
    let(:product_id) { create(:product).id }

    subject(:result) { AddProduct.new.call(cart: cart, product_id: product_id, quantity: quantity) }

    describe 'empty cart' do
      context '5 items or less' do
        let(:quantity) { 5 }

        it 'returns success' do
          expect(result.success?).to eq true
        end

        it 'add new product to cart' do
          expect(result.success.items.count).to eq 1
        end

        it 'has correct final price' do
          final_price = result.success.items.last.final_price_cents

          expect(final_price).to eq 5000
        end
      end

      context 'more then 5 products - errors expected' do
        let(:quantity) { 6 }

        it 'returns failure' do
          expect(result.failure?).to eq true
        end

        it 'returns error message' do
          expect(result.failure[:message]).to eq 'Maximum quantity exceeded (you cannot add more then 5 items)'
        end
      end
    end

    describe 'cart full (already contains 10 products)' do
      let(:cart) { create(:cart, :full_cart) }

      context '1 new product' do
        let(:quantity) { 1 }

        it 'returns failure' do
          expect(result.failure?).to eq true
        end

        it 'returns error message' do
          expect(result.failure[:message]).to eq 'Maximum amount of products in cart exceeded (no more than 10 items allowed)'
        end
      end
    end
  end
end
