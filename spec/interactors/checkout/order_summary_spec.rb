require 'rails_helper'

RSpec.describe Checkout::OrderSummary do

  subject(:step) { described_class.new(checkout: checkout, cart: cart) }

  describe '#new' do
    context 'Order summary' do
      let(:checkout) {
        {
          'address' => {
            'first_name' => 'Jan',
            'last_name' => 'Kowalski',
            'address_line' => '3-go maja 23',
            'city' => 'Wrocław',
            'postal_code' => '53-407',
            'phone_number' => '+48503633896'
          },
          'delivery_method' => {
            'name' => 'DHL'
          },
          'payment' => {}
        }
      }

      let(:cart) { ShoppingCart.new({'1' => 2}) }

      it 'should have address object' do
        expect(subject.address.is_a?(Checkout::Forms::Address)).to eq true
      end

      it 'should have delivery_method object' do
        expect(subject.delivery_method.is_a?(Checkout::Forms::DeliveryMethod)).to eq true
      end

      it 'should have payment object' do
        expect(subject.payment.is_a?(Checkout::Forms::Payment)).to eq true
      end

      it 'should have ShoppingCart object' do
        expect(subject.cart.is_a?(ShoppingCart)).to eq true
      end
    end
  end
end
