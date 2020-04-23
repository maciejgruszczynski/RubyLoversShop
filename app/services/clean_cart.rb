class CleanCart
  def call(cart)
    cart.items.delete_all
  end
end
