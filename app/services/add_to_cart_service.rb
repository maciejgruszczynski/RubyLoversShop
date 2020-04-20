class AddToCartService
  def call(cart, params)
    product = Product.find(params[:id])
    quantity = params[:quantity].to_i
    cart = create_cart if cart.new_record?
    update_cart_item(cart, product, quantity) if product_in_cart?(cart, product)
    add_new_item(cart, product, quantity) if product_not_in_cart?(cart, product)
    cart
  end

  private

  def create_cart
    @cart = CreateCartService.new.call
  end

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
    item.update(quantity: item.quantity + quantity, final_price_cents: item.final_price_cents + (quantity * product.price_cents))
  end

  def update_cart(value_cents, value_currency)
    @cart.update(value_cents: value_cents, value_currency: value_currency)
  end

  def product_not_in_cart?(cart, product)
    cart.items.select {|e| e.product_id == product.id}.empty?
  end

  def product_in_cart?(cart, product)
    cart.items.select {|e| e.product_id == product.id}.any?
  end

  def update_product_in_cart(product, quantity)
    item = CartItem.find_by(product_id: product.id)
    new_quantity = item.quantity + quantity
    new_final_price = item.final_price_cents + (new_quantity * product.price_cents)
    item.update(quantity: new_quantity, final_price_cents: new_final_price)
  end
end
