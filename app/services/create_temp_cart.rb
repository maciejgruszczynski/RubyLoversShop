class CreateTempCart

  def call(user_id:)
    Cart.new(identifier: generate_cart_identifier, user_id: user_id)
  end

  def generate_cart_identifier
    SecureRandom.base58(8).upcase
  end
end
