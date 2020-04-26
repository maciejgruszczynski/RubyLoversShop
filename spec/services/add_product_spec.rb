require 'rails_helper'

describe 'AddProduct' do
  describe "call" do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }
    let(:cart_item_params) { params = {cart_identifier: cart.identifier, product_id: product.id, quantity: quantity} }

    describe "empty cart" do
      context "1 product - no errors expected" do
        let(:quantity) { 1 }
        subject(:add_product) {AddProduct.new.call(cart, cart_item_params).success?}

        it { is_expected.to eq true }
      end

      context "6 products - errors expected" do
        let(:quantity) { 6 }
        subject(:add_product) {AddProduct.new.call(cart, cart_item_params).success?}

        it { is_expected.to eq false }
      end

      context "Saved cart item has correct final price" do
        let(:quantity) { 5 }
        subject(:add_product) {AddProduct.new.call(cart, cart_item_params).success.items.last.final_price_cents}

        it { is_expected.to eq 5000 }
      end
    end

    describe "cart full (already contains 10 products)" do
      let(:full_cart) { create(:cart, :full_cart) }

      context "1 new product - errors expected" do
        let(:quantity) { 1 }
        subject(:add_product) { AddProduct.new.call(full_cart, cart_item_params).success? }

        it { is_expected.to eq false }
      end
    end
  end
end
