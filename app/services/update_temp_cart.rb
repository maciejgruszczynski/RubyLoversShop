class UpdateTempCart
  def call(cart:, user_id:)
    cart.user_id: user_id)
  end

  def generate_cart_identifier
    SecureRandom.base58(8).upcase
  end
end
