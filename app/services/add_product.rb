class AddProduct
  include Dry::Monads[:result]

  def call(cart:, product_id:, quantity:)
    product = Product.find(product_id)
    quantity = quantity.to_i

    return Failure(message: "Max quantity exceeded (you cannot add more then #{Cart::MAX_ITEM_OCCURENCES} items") if quantity_invalid?(quantity)

    return Failure(message:'max 10 items allowed') if max_items_count_exceded?(cart)

    return Success(cart) if add_new_item(cart, product, quantity)
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

  def quantity_invalid?(quantity)
    quantity > Cart::MAX_ITEM_OCCURENCES
  end

  def max_items_count_exceded?(cart)
    cart.items.count >= Cart::MAX_ITEMS
  end
end
