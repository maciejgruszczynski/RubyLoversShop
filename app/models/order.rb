class Order < ApplicationRecord
  has_many :addresses
  has_one :payment

  def final_price
    Money.new(self.final_price_cents, self.final_price_currency)
  end
end
