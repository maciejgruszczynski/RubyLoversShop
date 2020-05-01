class CreateTempCart
  include Dry::Monads[:result]

  def call
    cart = Cart.new(identifier: generate_cart_identifier)
    Success(cart: cart)
  end

  def generate_cart_identifier
    SecureRandom.base58(8).upcase
  end
end
