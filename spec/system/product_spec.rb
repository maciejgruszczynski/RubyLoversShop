require 'rails_helper'

describe 'product', type: :feature do
  before(:all) do
    @product = FactoryBot.build(:shirt)
    @product.save
  end

  it 'shows list of products' do
    visit '/products'

    expect(page).to have_content 'RubyLoversShop'
    within('#products') do
      expect(page).to have_content "#{@product.name}"
      expect(page).to have_content '$10.00'
    end
  end

  it 'can display produt details' do
    visit '/products'
    click_on("#{@product.name}")

    expect(current_path).to eql(product_path(@product))
    expect(page).to have_content "#{@product.name} (#{@product.code})"
    expect(page).to have_content @product.description
    expect(page).to have_content 'Price: $10.00'
  end

  it 'can search for products' do
    @product2 = FactoryBot.build(:shirt)
    @product2.save
    @product3 = FactoryBot.build(:shoes)
    @product3.save

    visit '/products'
    fill_in 'name', with: 'Shi'
    click_on('Search')

    expect(current_path).to eql(search_products_path)
    within('#products') do
      expect(page).to have_content "#{@product.name}"
      expect(page).to have_content "#{@product2.name}"
      expect(page).to have_no_content "#{@product3.name}"
    end
  end

  it 'cannot search for products if search field empty' do
    visit '/products'
    click_on('Search')

    validation_message = page.find('#name').native.attribute('validationMessage')
    expect(validation_message).to eq 'Please fill in this field.'
  end
end
