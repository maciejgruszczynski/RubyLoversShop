require 'rails_helper'

describe 'product', type: :feature do

  context "display products" do
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

  context "pagination" do
    let!(:shirts) { create_list(:product, 20, :shirt) }

    it 'can display pagination on index page if > 10 products' do
      visit '/products'

      expect(page).to have_content "Previous"
      expect(page).to have_content "Next"
    end

    it 'can display pagination on search results page if > 10 products' do
      visit '/products/search?q=Shirt'

      expect(page).to have_content "Previous"
      expect(page).to have_content "Next"
    end
  end

  context "search for products" do
    let!(:shirts) { create_list(:product, 3, :shirt) }
    let!(:pants) { create_list(:product, 3, :pants) }

    it 'can search for products' do
      visit '/products'
      fill_in 'q', with: 'Shi'
      click_on('Search')

      expect(current_path).to eql(search_products_path)

      within('#products') do
        shirts.each { |shirt| expect(page).to have_content shirt.name }
        pants.each { |pants| expect(page).to have_no_content pants.name}
      end
    end

    it 'cannot search for products if search field empty' do
      visit '/products'
      click_on 'Search'

      validation_message = page.find('#q').native.attribute('validationMessage')
      expect(validation_message).to eq 'Please fill in this field.'
    end
  end
end
