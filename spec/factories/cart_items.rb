FactoryBot.define do
  factory(:cart_item) do
    association :cart_id
    association :product_id
    product_code { product.code }
    product_name { product.name }
    quantity { 1 }
    unit_price { 1000 }
    final_price { 1000 }
  end
end
