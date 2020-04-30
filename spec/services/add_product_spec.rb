require 'rails_helper'

describe 'AddProduct' do
  describe "call" do
    let(:cart) { create(:cart) }
    let(:product_id) { create(:product).id }

    describe "empty cart" do
      context "1 product - no errors expected" do
        let(:quantity) { 1 }
        subject(:add_product) { AddProduct.new.call(cart: cart, product_id: product_id, quantity: quantity).success? }

        it { is_expected.to eq true }
      end

      context "6 products - errors expected" do
        let(:quantity) { 6 }
        subject(:add_product) { AddProduct.new.call(cart: cart, product_id: product_id, quantity: quantity).success? }

        it { is_expected.to eq false }
      end

      context "Saved cart item has correct final price" do
        let(:quantity) { 5 }
        subject(:add_product) { AddProduct.new.call(cart: cart, product_id: product_id, quantity: quantity).success.items.last.final_price_cents }

        it { is_expected.to eq 5000 }
      end
    end

    describe "cart full (already contains 10 products)" do
      let(:full_cart) { create(:cart, :full_cart) }

      context "1 new product - errors expected" do
        let(:quantity) { 1 }
        subject(:add_product) { AddProduct.new.call(cart: full_cart, product_id: product_id, quantity: quantity).success? }

        it { is_expected.to eq false }
      end
    end
  end
end
