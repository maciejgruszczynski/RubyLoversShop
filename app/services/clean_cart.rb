class CleanCart

  def call(cart: )
    cart.items.destroy_all
    cart
  end
end
