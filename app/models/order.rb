class Order < ApplicationRecord
  def final_price
    Money.new(self.final_price_cents, self.final_price_currency)
  end
end
