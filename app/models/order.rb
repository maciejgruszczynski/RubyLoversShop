require 'aasm'

class Order < ApplicationRecord
  include AASM

  aasm(:state) do
    state :new, initial: true
    state :with_customer_data
    state :with_delivery_method
    state :waiting_for_payment
    state :paid

    event :fill_with_customer_data do
      transitions from: :new, to: :with_customer_data
    end

    event :fill_with_delivery_method do
      transitions from: :with_customer_data, to: :with_delivery_method
    end

    event :pay do
      transitions from: :with_delivery_method, to: :waiting_for_payment
    end

    event :confirm_payment do
      transitions from: :waiting_for_payment, to: :paid
    end
  end

  def final_price
    Money.new(self.final_price_net_cents, self.final_price_net_currency)
  end
end
