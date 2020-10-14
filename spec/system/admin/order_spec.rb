require 'rails_helper'

describe 'orders', type: :system do
  let(:admin) { create(:admin_user) }
  let(:order) { create(:order) }

  context 'list of orders' do
    before do
      order.save!
      login_as(admin, scope: :admin_user)
    end

    it 'displays list of orders' do
      visit '/admin/orders'

      within("#order_search") do
        expect(page).to have_content 'Customer email contains'
        expect(page).to have_content 'State contains'
      end

      within('#orders') do
        expect(page).to have_content 'Order identifier'
        expect(page).to have_content 'State'
        expect(page).to have_content 'Delivery method'
        expect(page).to have_content 'Customer email'
        expect(page).to have_content 'Total'

        expect(page).to have_content 'AA111'
        expect(page).to have_content 'new'
        expect(page).to have_content 'DHL'
        expect(page).to have_content 'customer@email.com'
        expect(page).to have_content '$100.00'
      end
    end
  end
end
