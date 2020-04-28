require 'rails_helper'

describe 'UpdateCart' do
  describe "call" do
    let(:cart) { create(:cart, :cart_with_products) }
    let(:first_item) { cart.items.first }
    let(:second_item) { cart.items.second }
    let(:first_product_id) { cart.items.first.product_id }
    let(:cart_item_params) { params = {id: cart.id, items: { first_item.id => { quantity: quantity }, second_item.id => {quantity: quantity } } } }

    describe "all new quantities are correct" do
      context "no errors expected" do
        let(:quantity) { 2 }
        subject(:update_cart) { UpdateCart.new.call(cart, cart_item_params).success? }

        it { is_expected.to eq true }
      end

      context "new items quantities in cart expected" do
        let(:quantity) { 2 }
        subject(:update_cart) { UpdateCart.new.call(cart, cart_item_params).success.items.where(product_id: first_product_id).first.quantity }

        it { is_expected.to eq 2 }
      end

      context "new final_price_cents expeted" do
        let(:quantity) { 2 }
        subject(:update_cart) { UpdateCart.new.call(cart, cart_item_params).success.items.where(product_id: first_product_id).first.final_price_cents }

        it { is_expected.to eq 2000 }
      end
    end

    describe "new quantities are not correct" do
      context "failure expected" do
        let(:quantity) { 6 }
        subject(:update_cart) { UpdateCart.new.call(cart, cart_item_params).failure? }

        it { is_expected.to eq true }
      end
    end
  end
end
