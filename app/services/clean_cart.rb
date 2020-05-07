class CleanCart
  include Dry::Monads[:result]

  def call(cart: )
    cart.items.destroy_all
    cart
  end
end
