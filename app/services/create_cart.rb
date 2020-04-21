class CreateCart
  def call
    identifier = SecureRandom.base58(8).upcase
    cart = Cart.new(identifier: identifier)
    cart.save
    cart
  end
end
