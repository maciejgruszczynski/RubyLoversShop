module CartHelper
  def total_price(product_id, quantity)
    humanized_money_with_symbol quantity.to_i * current_cart.storage.product(product_id: product_id).price
  end
end
