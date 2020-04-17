require 'rails_helper'

RSpec.describe Product, type: :model do

  context 'Validation' do
    let(:product) { build(:shirt) }

    it 'Product name is mandatory' do
      should validate_presence_of(:name)
    end

    it 'Product description is mandatory' do
      should validate_presence_of(:description)
    end

    it 'Product code is mandatory and has 6 characters' do
      should validate_presence_of(:code)
      should validate_length_of(:code)
    end

    it 'Product code is unique' do
      should validate_uniqueness_of(:code).case_insensitive
    end

    it 'Product price is mandatory' do
      is_expected.to monetize(:price)
    end
  end

  context 'Search' do
    let!(:shirts) { create_list(:shirt, 3) }
    let!(:pants) { create_list(:pants, 3) }

    subject(:search_results) { Product.search_by_name(@name) }

    it 'looks for products - product name with lower case' do
      @name = 'Shi'

      expect(search_results.count).to eq 3
    end

    it 'looks for products - product name with upper case' do
      @name = "SHI"

      expect(search_results.count).to eq 3
    end

    it 'looks for products if query contains % ' do
      @name = "%"

      expect(search_results.count).to eq 0
    end

    it 'looks for products if query contains _ ' do
      Product.first.update(name: "name")

      @name = "_"

      expect(search_results.count).to eq 0
    end

    it "finds no products if name is null" do
      @name = ""

      expect(search_results.count).to eq 0
    end

    it "finds products if 1 letter is omitted" do
      @name = "Shrt"

      expect(search_results.count).to eq 3
    end

    it "finds products if only 2 first letters are given" do
      @name = "pa"

      expect(search_results.count).to eq 3
    end

    it "finds products that sounds similar" do
      @name = "shert"

      expect(search_results.count).to eq 3
    end
  end
end
