describe "product", type: :feature do
  before do
    #@product = build(:product)
  end

  it "shows list of products" do
    visit('/products')
    within("#products") do
      expect(page).to have_content "product"
    end
  end
end
