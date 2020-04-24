class UpdateProduct
  def call(cart, params)
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    if max_items_count_not_exceded?(cart)
      update_cart_item(cart, product, quantity)
    else
      cart.errors.add(:items, 'max 10 items allowed')
    end
    cart
  end

  private

  def update_cart_item(cart, product, quantity)
    item = cart.items.find_by(product_id: product.id)
    new_quantity = item.quantity + quantity
    new_final_price_cents = item.final_price_cents + (quantity * product.price_cents)
    if item.update(quantity: new_quantity, final_price_cents: new_final_price_cents)
      cart
    else
      cart.errors.add(:item, "Max number of items: #{Cart::MAX_ITEM_OCCURENCES}")
      cart
    end
  end

  def max_items_count_not_exceded?(cart)
    if cart.items.count <= Cart::MAX_ITEMS
      true
    end
  end
end
