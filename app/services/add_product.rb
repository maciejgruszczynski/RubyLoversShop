class AddProduct
  def call(cart, params)
    product = Product.find(params[:id])
    quantity = params[:quantity].to_i

    if max_items_count_not_exceded?(cart)
      update_cart_item(cart, product, quantity) if product_in_cart?(cart, product)
      add_new_item(cart, product, quantity) if product_not_in_cart?(cart, product)
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

  def product_not_in_cart?(cart, product)
    cart.items.select {|e| e.product_id == product.id}.empty?
  end

  def product_in_cart?(cart, product)
    cart.items.select {|e| e.product_id == product.id}.any?
  end

  def max_items_count_not_exceded?(cart)
    if cart.items.count == Cart::MAX_ITEMS
      false
    end
  end
end
