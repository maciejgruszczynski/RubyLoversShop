require 'rails_helper'

describe 'UpdateProduct' do
  describe "call" do
    let(:cart) { create(:cart, :cart_with_products) }
    let(:product_id) {cart.items.first.product_id}

    describe "cart with products" do
      context "1 product - no errors expected" do
        let(:quantity) { 1 }
        subject(:add_product) { UpdateProduct.new.call(cart: cart, product_id: product_id, quantity: quantity).success? }

        it { is_expected.to eq true }
      end

      context "1 product - 2 items in cart expected" do
        let(:quantity) { 1 }
        subject(:add_product) { UpdateProduct.new.call(cart: cart, product_id: product_id, quantity: quantity).success.items.where(product_id: product_id).first.quantity }

        it { is_expected.to eq 2 }
      end

      context "6 products - errors expected" do
        let(:quantity) { 6 }
        subject(:add_product) { UpdateProduct.new.call(cart: cart, product_id: product_id, quantity: quantity).success? }

        it { is_expected.to eq false }
      end

      context "Saved cart item has correct final price" do
        let(:quantity) { 4 }
        subject(:add_product) { UpdateProduct.new.call(cart: cart, product_id: product_id, quantity: quantity).success.items.where(product_id: product_id).first.final_price_cents }

        it { is_expected.to eq 5000 }
      end
    end
  end
end
