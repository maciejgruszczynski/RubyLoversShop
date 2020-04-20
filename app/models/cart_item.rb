class CartItem < ApplicationRecord
  belongs_to :cart

  validates :quantity, numericality: { less_than_or_equal_to: 5}
  validate :validate_max_items

  def unit_price
    Money.new(self.unit_price_cents, self.unit_price_currency)
  end

  def final_price
    Money.new(self.final_price_cents, self.final_price_currency)
  end

  def validate_max_items
    items = CartItem.where(cart_id: self.cart_id)
    if items.map { |e| e.quantity }.sum > 10
      errors.add(:quantity, 'max 10 items for cart allowed')
    end
  end
end
