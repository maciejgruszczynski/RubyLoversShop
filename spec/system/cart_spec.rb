require 'rails_helper'

describe 'cart', type: :feature do

  context "updates cart" do
    let(:cart) { create(:cart, :cart_with_products) }
    let(:item_1) { cart.items.first }
    let(:item_2) { cart.items.second }

    it 'updates products' do
      page.set_rack_session(cart: cart.identifier)

      visit "/carts/#{cart.id}"

      expect(page).to have_content 'Cart: $20.00'

      within("#cart") do
        select 5, from: "items_#{item_1.id}_quantity"
        select 4, from: "items_#{item_2.id}_quantity"
      end

      click_on "Update"

      within('#notice') do
        expect(page).to have_content 'Cart updated'
      end

      expect(page).to have_content 'Cart: $90.00'
      expect(current_path).to eql("/carts/#{cart.id}")
    end

    it 'cleans up cart' do
      page.set_rack_session(cart: cart.identifier)

      visit "/carts/#{cart.id}"

      click_on "Clean cart"

      within('#notice') do
        expect(page).to have_content 'Cart has been cleaned up'
      end

      expect(page).to have_content 'Cart: $0.00'
      expect(current_path).to eql("/carts/#{cart.id}")
    end

    it 'removes product from cart' do
      page.set_rack_session(cart: cart.identifier)

      visit "/carts/#{cart.id}"

      within("#cart") do
        first(:link, "Remove from cart").click
      end

      within('#notice') do
        expect(page).to have_content 'Product has been removed from cart'
      end

      expect(page).to have_content 'Cart: $10.00'
      expect(current_path).to eql("/carts/#{cart.id}")

      within('#cart') do
        expect(page).to have_selector('table tbody tr', count: 1)
      end
    end
  end
end
