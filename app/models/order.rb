require 'aasm'

class Order < ApplicationRecord
  include AASM

  aasm(:state) do
    state :new, initial: true
    state :with_customer_data
    state :with_delivery_method
    state :with_payment_info
    state :waiting_for_payment
    state :paid
    state :with_payment_errors

    event :fill_with_customer_data do
      transitions from: :new, to: :with_customer_data
    end

    event :fill_with_delivery_method do
      transitions from: :with_customer_data, to: :with_delivery_method
    end

    event :fill_with_payment_info do
      transitions from: :with_delivery_method, to: :with_payment_info
    end

    event :pay do
      transitions from: :with_payment_info, to: :waiting_for_payment
    end


    event :confirm_payment do
      transitions from: :waiting_for_payment, to: :paid
    end

    event :add_payment_errors do
      transitions from: :waiting_for_payment, to: :with_payment_errors
    end
  end

  def final_price
    Money.new(self.final_price_net_cents, self.final_price_net_currency)
  end
end
