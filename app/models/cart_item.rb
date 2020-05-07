class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def unit_price
    Money.new(self.unit_price_cents, self.unit_price_currency)
  end

  def final_price
    Money.new(self.final_price_cents, self.final_price_currency)
  end
end
