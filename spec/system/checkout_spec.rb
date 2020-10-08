require 'rails_helper'

describe 'checkout', type: :system do

  context 'place order based on cart content' do
    before do
      DeliveryMethod.create(name: 'DHL')
      DeliveryMethod.create(name: 'Inpost')
    end

    it 'places order' do
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

      expect(current_path).to eql('/checkout/payment')
      expect(page).to have_content 'Step 3: Payment'

      click_on 'Next'

      expect(current_path).to eql('/checkout/summary')
      expect(page).to have_content 'Step 4: Summary'

      expect(page).to have_content 'first_name: Jan'
      expect(page).to have_content 'last_name: Kowalski'
      expect(page).to have_content 'address_line: Krucza 8/24'
      expect(page).to have_content 'city: Wrocław'
      expect(page).to have_content 'postal_code: 53-407'
      expect(page).to have_content 'phone_number: 555 555 555'
      expect(page).to have_content 'delivery method: DHL'
    end
  end
end
