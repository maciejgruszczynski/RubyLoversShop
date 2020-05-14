module CartHelper
  def product(product_id)
    Product.find(product_id)
  end

  def total_price(product_id, quantity)
    humanized_money_with_symbol quantity.to_i * product(product_id).price
  end
end
