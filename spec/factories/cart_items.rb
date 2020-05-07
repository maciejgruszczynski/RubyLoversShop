FactoryBot.define do
  factory(:cart_item) do
    cart
    product
    product_code { product.code }
    product_name { product.name }
    quantity { 1 }
    unit_price_cents { 1000 }
    final_price_cents { 1000 }
  end
end
