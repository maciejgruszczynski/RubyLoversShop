class UpdateCart
  include Dry::Monads[:result]

  def call(cart:, items_after_update:)

    return Failure(
      message: "#{I18n.t('services.errors.max_quantity',
      limit: Cart::MAX_ITEM_OCCURENCES)}"
      ) unless all_quantities_valid?(items_after_update)

    if update_items(cart, items_after_update)
      Success(cart)
    else
      Failure(message: I18n.t('services.errors.other_error'))
    end
  end

  def update_items(cart, items_after_update)
    items_after_update.each do |item_after_update|
      item = CartItem.find(item_after_update[0].to_i)
      new_quantity = item_after_update.dig(1, :quantity).to_i
      new_final_price_cents = item.unit_price_cents * new_quantity
      item.update(quantity: new_quantity, final_price_cents: new_final_price_cents)
    end
    cart
  end

  def all_quantities_valid?(items_after_update)
    items_after_update.values.all? { |v| v[:quantity].to_i <= Cart::MAX_ITEM_OCCURENCES }
  end
end
