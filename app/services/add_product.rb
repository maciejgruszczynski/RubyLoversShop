class AddProduct
  def call(cart, params)
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    if max_items_count_not_exceded?(cart)
      add_new_item(cart, product, quantity)
    else
      cart.errors.add(:items, 'max 10 items allowed')
    end
    cart
  end

  private

  def add_new_item(cart, product, quantity)
    final_price_cents = quantity * product.price_cents
    item =  CartItem.new(
      cart_id: cart.id,
      product_id: product.id,
      product_name: product.name,
      product_code: product.code,
      quantity: quantity,
      unit_price_cents: product.price_cents,
      unit_price_currency: product.price_currency,
      final_price_cents: final_price_cents,
      final_price_currency: product.price_currency)

    cart.items << item
  end

  def max_items_count_not_exceded?(cart)
    if cart.items.count <= Cart::MAX_ITEMS
      true
    end
  end
end
