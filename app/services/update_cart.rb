class UpdateCart
  include Dry::Monads[:result]

  def call(cart:, items:)

    return Failure(message: "#{I18n.t('services.errors.max_quantity', limit: Cart::MAX_ITEM_OCCURENCES)}") unless all_quantities_valid?(items)

    if items_updated?(cart, items)
      Success(cart)
    else
      Failure(message: I18n.t('services.errors.other_error'))
    end
  end

  def items_updated?(cart, items)
    items.each do |i|
      item = CartItem.find(i[0].to_i)
      new_quantity = i.dig(1, :quantity).to_i
      new_final_price_cents = item.unit_price_cents * new_quantity
      item.update(quantity: new_quantity, final_price_cents: new_final_price_cents)
    end
    cart
  end

  def all_quantities_valid?(items)
    items.values.all? { |v| v[:quantity].to_i <= Cart::MAX_ITEM_OCCURENCES }
  end
end
