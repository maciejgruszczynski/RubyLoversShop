require 'rails_helper'

RSpec.describe ShoppingCart::Validators::CartItemQuantity do
  subject(:validator) { described_class.new.validate(item) }
  let(:item) { ShoppingCart::Entities::CartItem.new(product_id: 1, quantity: quantity) }

  describe '#validate' do
    context 'valid item' do
      let(:quantity) { 5 }

      it 'returns success' do
        expect(validator.success?).to eq true
      end
    end

    context 'invalid item' do
      let(:quantity) { 6 }

      it 'returns failure' do
        expect(validator.failure?).to eq true
      end

      it 'returns error message' do
        expect(validator.failure).to eq 'Maximum quantity exceeded (you cannot add more then 5 items)'
      end
    end
  end
end
