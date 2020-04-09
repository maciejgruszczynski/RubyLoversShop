describe "product", type: :feature do
  before do
    @product = build(:product)
    @product.save
  end

  it "shows list of products" do

    visit products_path

    expect(page).to have_content "RubyLoversShop"
    within("#products") do
      expect(page).to have_content "#{@product.name}"
    end
  end

  it "can display produt details" do
    visit products_path
    click_on("product")

    expect(current_path).to eql(product_path(@product))
    expect(page).to have_content "#{@product.name} (#{@product.code})"
    expect(page).to have_content @product.description
  end
end
