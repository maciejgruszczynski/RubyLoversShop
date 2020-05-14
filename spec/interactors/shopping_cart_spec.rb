require 'rails_helper'

RSpec.describe ShoppingCart do
  describe 'new' do
    subject { ShoppingCart.new(session) }

    context 'cart is not present in session' do
      let(:session) { {} }

      it 'returns {}' do
        expect(subject.cart).to eq Hash.new
      end
    end

    context 'cart is present in session' do
      let(:session) { { :cart => { '1' => 2 } } }

      it 'returns cart content' do
        expect(subject.cart).to eq ({'1' => 2})
      end
    end
  end

  describe '#add_item' do
    context 'valid quantity' do

    end

    context 'in valid quantity - quantity > 5' do

    end

    context 'cart has < 10 cart items' do

    end

    context 'cart has 10 cart items' do

    end

    context 'cart has > 10 cart items' do
      
    end
  end

  describe '#remove_item' do

  end

  describe '#update_item' do
    context 'valid quantity' do

    end

    context 'invalid quantity - quantity > 5' do

    end

  end

  describe 'update_cart' do

  end

  describe '#clean_cart' do

  end

end
