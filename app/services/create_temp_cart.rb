class CreateTempCart
  def call
    Cart.new(identifier: Generators.new.cart_identifier)
  end
end
