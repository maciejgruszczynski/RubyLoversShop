require 'rails_helper'

RSpec.describe Product, type: :model do

  let(:product) { build(:shirt) }

  context 'Validation' do

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
end
