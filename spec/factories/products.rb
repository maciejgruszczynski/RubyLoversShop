FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Shirt_#{n}" }
    name { 'product' }
    description { 'description' }
    #sequence(:code, (100000..10010).cycle) { initial_product_code.next }
    sequence(:code) {|n| "000000".next}
    price_cents { 1000 }
    price_currency { 'USD' }
  end
end
