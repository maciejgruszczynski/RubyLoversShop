class Product < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :code, presence: true, uniqueness: {case_sensitive: false}, length: { is: 6 }
  monetize :price_cents, numericality: { greater_than: 0 }

  def price
    Money.new(self.price_cents, self.price_currency)
  end

end
