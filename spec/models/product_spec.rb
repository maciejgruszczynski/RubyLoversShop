require 'rails_helper'

describe Product, type: :model do
  describe "validation" do
    let(:shirt) { build(:shirt) }

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

  describe "Search" do
    let!(:shirts) { create_list(:shirt, 3) }
    let!(:pants) { create_list(:pants, 3) }

    subject(:search_results) { Product.search_by_name(name).count }

    context "product name with lower case" do
      let(:name) { 'shi' }
      it { is_expected.to eq 3 }
    end

    context "product name with upper case" do
      let(:name) { 'SHI' }
      it { is_expected.to eq 3 }
    end

    context "product name contains %" do
      let(:name) { '%' }
      it { is_expected.to eq 0 }
    end

    context "product name contains _" do
      let(:name) { '_' }
      it { is_expected.to eq 0 }
    end

    context "product name is null" do
      let(:name) { '' }
      it { is_expected.to eq 0 }
    end

    context "1 letter is omitted in product name" do
      let(:name) { 'Shrt' }
      it { is_expected.to eq 3 }
    end

    context "only 2 first letters of name are given" do
      let(:name) { 'pa' }
      it { is_expected.to eq 3 }
    end

    context "Product name that sounds similar" do
      let(:name) { 'shert' }
      it { is_expected.to eq 3 }
    end
  end
end
