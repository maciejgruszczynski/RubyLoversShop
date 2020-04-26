class CleanCart
  def call(cart)
    cart.items.delete_all
    cart
  end
end
