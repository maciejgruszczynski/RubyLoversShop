class UpdateCart
  include Dry::Monads[:result]

  def call(cart:, items:)

    return Failure(message: "Max quantity exceeded (you cannot add more then #{Cart::MAX_ITEM_OCCURENCES} items") unless all_quantities_valid?(items)

    return Success(cart) if items_updated?(cart, items)
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
