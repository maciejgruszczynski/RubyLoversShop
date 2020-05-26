require 'rails_helper'

RSpec.describe ShoppingCart do
  let(:shopping_cart) { described_class.new(session) }
  let(:storage) { shopping_cart.cart.storage }

  describe 'new' do
    context 'cart is not present in session' do
      let(:session) { {} }

      it 'returns {}' do
        expect(storage).to eq ({})
      end
    end

    context 'cart is present in session' do
      let(:session) { { :cart => { '1' => 2 } } }

      it 'returns cart content' do
        expect(storage).to eq ({'1' => 2})
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
          expect { add_item }.to change { storage.size }.by(1)
        end
      end

      context 'invalid quantity - quantity > 5' do
        let(:quantity) { 6 }

        it 'returns failure' do
          expect { add_item }.to_not change { storage.size }
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
        expect { add_item }.to_not change { storage.size }
      end
    end
  end

  describe '#remove_item' do
    context 'cart with items' do
      let(:session) { { :cart => { '1' => 2 } } }
      subject(:remove_item) { shopping_cart.remove_item(product_id: 1) }

      it 'returns success' do
        expect { remove_item }.to change { storage.size }.from(1).to(0)
      end
    end
  end

  describe '#update_item' do
    let(:session) { { :cart => { '1' => 2 } } }
    let(:product_id) { '1' }
    subject(:update_item) { shopping_cart.update_item(product_id: product_id, quantity: quantity)}

    context 'valid quantity' do
      let(:quantity) { 1 }

      it 'returns success' do
        expect { update_item }.to change { storage['1'] }.from(2).to(3)
      end
    end

    context 'invalid quantity - quantity > 5' do
      let(:quantity) { 4 }

      it 'returns failure' do
        expect { update_item }.to_not change { storage['1'] }
      end
    end
  end

  describe '#update_cart' do
    let(:session) { { :cart => { '1' => 2, '2' => 2 } } }
    subject(:update_cart) { shopping_cart.update_cart(items_after_update: update_params) }

    context 'valid quantities' do
      let(:update_params) {
        {
          '1' => { 'quantity' => '5' },
          '2' => { 'quantity' => '5' }
        }
      }

      it 'returns success' do
        expect { update_cart }.to change { storage.values }.to all (be 5)
      end
    end

    context 'one of quantities is invalid (> 5)' do
      let(:update_params) {
        {
          '1' => { 'quantity' => 6 },
          '2' => { 'quantity' => 5 }
        }
      }

      it 'returns failure' do
        expect { update_cart }.to_not change { storage['1'] }
        expect { update_cart }.to_not change { storage['5'] }
      end
    end
  end

  describe '#destroy' do
    subject(:destroy) { shopping_cart.destroy }

    context 'cart has items' do
      let(:session) { { :cart => { '1' => 2 } } }

      it 'destroys all items in cart' do
        expect { destroy }.to change { storage }.to be {}
      end
    end
  end
end
