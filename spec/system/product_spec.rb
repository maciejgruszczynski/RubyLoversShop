require 'rails_helper'

describe 'product', type: :feature do
  before(:all) do
    @product = build(:product)
    @product.save
  end

  it 'shows list of products' do

    visit '/products'

    expect(page).to have_content 'RubyLoversShop'
    within('#products') do
      expect(page).to have_content "#{@product.name}"
      expect(page).to have_content "$10.00"

    end
  end

  it 'can display produt details' do
    visit '/products'
    click_on('product')

    expect(current_path).to eql(product_path(@product))
    expect(page).to have_content "#{@product.name} (#{@product.code})"
    expect(page).to have_content @product.description
    expect(page).to have_content "Price: $10.00"

  end
end
