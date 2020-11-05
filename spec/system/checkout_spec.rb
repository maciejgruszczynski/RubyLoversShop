require 'rails_helper'

describe 'checkout', type: :system do

  context 'place order based on cart content' do
    let(:shirt) { create(:product, :shirt) }
    let(:cart) { { shirt.id => 2 } }

    before do
      DeliveryMethod.create(name: 'DHL')
      DeliveryMethod.create(name: 'Inpost')
    end

    it 'places order' do
      page.set_rack_session(cart: cart)

      visit '/carts'
      click_on 'Checkout'

      expect(current_path).to eql('/checkout/address')
      expect(page).to have_content 'Step 1: Address'

      fill_in 'checkout_first_name', with: 'Jan'
      fill_in 'checkout_last_name', with: 'Kowalski'
      fill_in 'checkout_address_line', with: 'Krucza 8/24'
      fill_in 'checkout_city', with: 'Wrocław'
      fill_in 'checkout_postal_code', with: '53-407'
      fill_in 'checkout_phone_number', with: '555 555 555'

      click_on 'Next'

      expect(current_path).to eql('/checkout/delivery_method')
      expect(page).to have_content 'Step 2: Delivery Method'

      choose(option: 'DHL')

      click_on 'Next'

      expect(current_path).to eql('/checkout/payment_info')
      expect(page).to have_content 'Step 3: Payment info'

      fill_in 'checkout_customer_email', with: 'a@a.pl'
    end
  end
end
