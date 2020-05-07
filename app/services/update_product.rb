class UpdateProduct
  include Dry::Monads[:result]

  def call(cart:, product_id:, quantity:)
    product = Product.find(product_id)
    quantity = quantity.to_i

    return Failure(message: "#{I18n.t('services.errors.max_quantity', limit: Cart::MAX_ITEM_OCCURENCES)}") if quantity_invalid?(quantity)

    if update_cart_item(cart, product, quantity)
      Success(cart)
    else
      Failure(message: I18n.t('services.errors.other_error'))
    end
  end

  private

  def update_cart_item(cart, product, quantity)
    item = cart.items.find_by(product_id: product.id)
    new_quantity = item.quantity + quantity
    new_final_price_cents = item.final_price_cents + (quantity * product.price_cents)
    item.update(quantity: new_quantity, final_price_cents: new_final_price_cents)
    cart
  end

  def quantity_invalid?(quantity)
    quantity > Cart::MAX_ITEM_OCCURENCES
  end
end
