class CreateTempCart
  def call
    Cart.new(identifier: generate_cart_identifier)
  end

  def generate_cart_identifier
    SecureRandom.base58(8).upcase
  end
end
