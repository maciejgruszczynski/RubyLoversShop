class CreateCartService
  def call
    identifier = SecureRandom.base58(8).upcase
    cart = Cart.create!(identifier: identifier)
  end
end
