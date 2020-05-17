require 'rails_helper'

RSpec.describe ShoppingCart do
  subject(:shopping_cart) { described_class.new(session) }

  describe 'new' do
    context 'cart is not present in session' do
      let(:session) { {} }

      it 'returns {}' do
        expect(shopping_cart.storage).to eq ({})
      end
    end

    context 'cart is present in session' do
      let(:session) { { :cart => { '1' => 2 } } }

      it 'returns cart content' do
        expect(shopping_cart.storage).to eq ({'1' => 2})
      end
    end
  end

  describe '#add_item' do
    subject(:add_item) { shopping_cart.add_item(
      product_id: 1,
      quantity: quantity
      )
    }
    context 'cart has <= 10 cart items' do
      let(:session) { {} }

      context 'valid quantity' do
        let(:quantity) { 1 }

        it 'returns success' do
          expect(add_item.success?).to eq true
        end

        it 'add 1 item to storage' do
          expect(add_item.value!.storage.size).to eq 1
        end
      end

      context 'invalid quantity - quantity > 5' do
        let(:quantity) { 6 }

        it 'returns failure' do
          expect(add_item.failure?).to eq true
        end

        it 'returns error message' do
          expect(add_item.failure[:message]).to eq ["Maximum quantity exceeded (you cannot add more then 5 items)"]
        end
      end
    end

    context 'cart has > 10 cart items' do
      let(:session) { { :cart => {
          '1' => 2,
          '2' => 2,
          '3' => 2,
          '4' => 2,
          '5' => 2,
          '6' => 2,
          '7' => 2,
          '8' => 2,
          '9' => 2,
          '10' => 2
          }
        }
      }
      let(:quantity) { 1 }

      it 'returns failure' do
        expect(add_item.failure?).to eq true
      end

      it 'returns error message' do
        expect(add_item.failure[:message]).to eq ["Maximum amount of products in cart exceeded (no more than 10 items allowed)"]
      end
    end
  end

  describe '#destroy_item' do
    context 'cart with items' do
      let(:session) { { :cart => { '1' => 2 } } }
      subject(:destroy_item) { shopping_cart.destroy_item(product_id: 1) }

      it 'returns success' do
        expect(destroy_item.success?).to eq true
      end

      it 'removes item' do
        expect(destroy_item.value!.storage.size).to eq 0
      end
    end
  end

  describe '#update_item' do
    let(:session) { { :cart => { '1' => 2 } } }
    let(:product_id) { '1' }
    subject(:update_item) { shopping_cart.update_item(product_id: product_id, quantity: quantity)}

    context 'valid quantity' do
      let(:quantity) { 1 }

      it 'returns true' do
        expect(update_item.success?).to eq true
      end

      it 'updates quantity' do
        expect(update_item.value!.storage['1']).to eq 3
      end
    end

    context 'product not in cart' do
      let(:product_id) { '2' }
      let(:quantity) { 1 }

      it 'returns failure' do
        expect(update_item.failure?).to eq true
      end

      it 'returns error' do
        expect(update_item.failure[:message]).to eq 'Product not in the cart'
      end
    end

    context 'invalid quantity - quantity > 5' do
      let(:quantity) { 4 }

      it 'returns failure' do
        expect(update_item.failure?).to eq true
      end

      it 'returns errors message' do
        expect(update_item.failure[:message]).to eq ["Maximum quantity exceeded (you cannot add more then 5 items)"]
      end
    end
  end

  describe '#update_cart' do
    let(:session) { { :cart => { '1' => 2, '2' => 2 } } }
    subject(:update_cart) { shopping_cart.update(update_params) }

    context 'valid quantities' do
      let(:update_params) { { '1' => 5, '2' => 5 } }

      it 'returns success' do
        expect(update_cart.success?).to eq true
      end

      it 'updates quantities' do
        expect(update_cart.value!.storage).to eq (update_params)
      end
    end

    context 'one of quantities is invalid (> 5)' do
      let(:update_params) { { '1' => 6, '2' => 3 } }

      it 'returns failure' do
        expect(update_cart.failure?).to eq true
      end

      it 'returns error message' do
        expect(update_cart..failure[:message]).to eq ["Maximum quantity exceeded (you cannot add more then 5 items)"]
      end
    end
  end

  describe '#destroy' do
    subject(:destroy) { shopping_cart.destroy }

    context 'cart has items' do
      let(:session) { { :cart => { '1' => 2 } } }

      it 'destroys all items in cart' do
        expect(destroy).to eq ({})
      end
    end
  end
end
