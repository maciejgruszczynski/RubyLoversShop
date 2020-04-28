class UpdateProduct
  include Dry::Monads[:result]

  def call(cart, params)
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    return Failure(message: "Max quantity exceeded (you cannot add more then #{Cart::MAX_ITEM_OCCURENCES} items") if quantity_invalid?(cart, product, quantity)

    return Success(cart) if update_cart_item(cart, product, quantity)
  end

  private

  def update_cart_item(cart, product, quantity)
    item = cart.items.find_by(product_id: product.id)
    new_quantity = item.quantity + quantity
    new_final_price_cents = item.final_price_cents + (quantity * product.price_cents)
    item.update(quantity: new_quantity, final_price_cents: new_final_price_cents)
    cart
  end


  def quantity_invalid?(cart, product, quantity)
    current_quantity = cart.items.select {|i| i.product_id = product.id}.first.quantity
    current_quantity + quantity > Cart::MAX_ITEM_OCCURENCES
  end
end
