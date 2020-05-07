require 'rails_helper'

describe 'product', type: :system do
  describe 'browse products' do
    context 'display products' do
      let!(:shirt) { create(:product, :shirt) }

      it 'shows list of products' do
        visit '/products'

        expect(page).to have_content 'RubyLoversShop'
        within('#products') do
          expect(page).to have_content shirt.name
          expect(page).to have_content '$10.00'
        end
      end

      it 'can display produt details' do
        visit '/products'
        click_on shirt.name

        expect(current_path).to eql(product_path(shirt))
        expect(page).to have_content "#{shirt.name} (#{shirt.code})"
        expect(page).to have_content shirt.description
        expect(page).to have_content 'Price: $10.00'
      end
    end

    context 'pagination' do
      let!(:shirts) { create_list(:product, 20, :shirt) }

      it 'can display pagination on index page if > 10 products' do
        visit '/products'

        expect(page).to have_content 'Previous'
        expect(page).to have_content 'Next'
      end

      it 'can display pagination on search results page if > 10 products' do
        visit '/products/search?q=Shirt'

        expect(page).to have_content 'Previous'
        expect(page).to have_content 'Next'
      end
    end

    context 'search for product' do
      let!(:shirts) { create_list(:product, 3, :shirt) }
      let!(:pants) { create_list(:product, 3, :pants) }

      it 'can search for products' do
        visit '/products'
        fill_in 'q', with: 'Shi'
        click_on 'Search'

        expect(current_path).to eql(search_products_path)

        within('#products') do
          shirts.each { |shirt| expect(page).to have_content shirt.name }
          pants.each { |pants| expect(page).to have_no_content pants.name}
        end
      end
    end
  end

  describe 'Add product to cart' do
    context 'Cart does not exist' do
      let!(:shirt) { create(:product, :shirt) }

      it 'Can add product to cart' do
        visit "/products/#{shirt.id}"
        select 2, from: 'cart_item_quantity'
        click_on 'Add to cart'

        expect(page).to have_content 'RubyLoversShop' #needs this assertion to wait for cart to load

        item = shirt.cart_items.last
        cart = item.cart

        expect(current_path).to eql("/carts/#{cart.id}")
        expect(page).to have_content "Cart show (#{cart.identifier})"
        expect(page).to have_content 'Cart: $20.00'

        within('#cart') do
          expect(page).to have_link(shirt.name, href: "/products/#{shirt.id}")
          expect(page).to have_select("items_#{item.id}_quantity", selected: '2')
          expect(page).to have_content('$10.00')
          expect(page).to have_content('$20.00')
          expect(page).to have_link('Remove from cart', href: "/cart_items/#{item.id}")
        end
      end
    end

    context 'Cart exists and have < 10 products' do
      let(:shirt) { create(:product, :shirt) }
      let(:cart) { create(:cart, :cart_with_products) }

      it 'Can add product to cart' do
        page.set_rack_session(cart: cart.identifier)

        visit "/products/#{shirt.id}"

        expect(page).to have_content 'Cart: $20.00'

        select 2, from: 'cart_item_quantity'
        click_on 'Add to cart'

        expect(page).to have_content 'RubyLoversShop' #needs this assertion to wait for cart to load

        item = shirt.cart_items.last

        expect(current_path).to eql("/carts/#{cart.id}")
        expect(page).to have_content "Cart show (#{cart.identifier})"
        expect(page).to have_content 'Cart: $40.00'

        within('#cart') do
          expect(page).to have_link(shirt.name, href: "/products/#{shirt.id}")
          expect(page).to have_select("items_#{item.id}_quantity", selected: '2')
          expect(page).to have_content('$10.00')
          expect(page).to have_content('$20.00')
          expect(page).to have_link('Remove from cart', href: "/cart_items/#{item.id}")
        end
      end
    end

    context 'Cart exists and have 10 products' do
      let(:shirt) { create(:product, :shirt) }
      let(:cart) { create(:cart, :full_cart) }

      it 'Can add product to cart' do
        page.set_rack_session(cart: cart.identifier)

        visit "/products/#{shirt.id}"

        select 2, from: 'cart_item_quantity'
        click_on 'Add to cart'

        within('#notice') do
          expect(page).to have_content 'Maximum amount of products in cart exceeded (no more than 10 items allowed)'
        end
      end
    end
  end
end
