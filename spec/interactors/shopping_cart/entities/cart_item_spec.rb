require 'rails_helper'

RSpec.describe ShoppingCart::Entities::CartItem do
  let(:product_id) { 1 }
  let(:quantity) { 5 }
  subject(:cart_item) {described_class.new(product_id: product_id, quantity: quantity)}

  describe 'new' do
    context 'correct cart_item attributes' do

      it 'creates new cart_item object' do
        expect(cart_item.is_a? ShoppingCart::Entities::CartItem).to eq true
      end

      it 'has correct product_id' do
        expect(cart_item.product_id).to eq 1
      end

      it 'has correct quantity' do
        expect(cart_item.quantity).to eq 5
      end
    end
  end
end
