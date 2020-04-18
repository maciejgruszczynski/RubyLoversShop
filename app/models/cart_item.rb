class CartItem < ApplicationRecord
  belongs_to :cart
  has_one :product
end
