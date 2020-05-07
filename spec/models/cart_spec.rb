require 'rails_helper'

describe Cart, type: :model do
  let(:cart) {create(:cart)}


  describe 'validation' do
    it 'Identifier is mandatory' do
      should validate_presence_of(:identifier)
    end

    it 'Identifier is uniue' do
      should validate_uniqueness_of(:identifier)
    end

    it 'Identifier is 8 chars long' do
      should validate_length_of(:identifier)
    end
  end
end
