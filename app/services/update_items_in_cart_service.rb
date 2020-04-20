class UpdateItemsInCartService
  def call(cart, params)
    #binding.pry
    cart = cart
    items = params[:items]
    items.each do |i|
      item = CartItem.find(i[0].to_i)
      new_quantity = params[:items][i[0]]['quantity'].to_i

      if item.quantity != new_quantity
        item.update(quantity: new_quantity, final_price_cents: new_quantity * item.unit_price_cents)
      end
    end
  end
end
