class UpdateCart
  def call(cart, params)
    items = params[:items]
    items.each do |i|
      item = CartItem.find(i[0].to_i)
      new_quantity = i.dig(1, :quantity).to_i

      if new_quantity_valid?(cart, new_quantity)
        if item.quantity != new_quantity
          new_final_price_cents = item.unit_price_cents * new_quantity
          item.update(quantity: new_quantity, final_price_cents: new_final_price_cents)
        end
      else
        cart.errors.add(:item, "Max number of items: #{Cart::MAX_ITEM_OCCURENCES}")
      end
    end
  end

  def new_quantity_valid?(cart, quantity)
    false if quantity > Cart::MAX_ITEM_OCCURENCES
  end
end
