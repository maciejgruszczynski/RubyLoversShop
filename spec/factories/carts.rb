FactoryBot.define do
  factory(:cart) do
    identifier { 'ABCDEFGA' }
  end

  trait :full_cart do
    identifier { '11111111' }

    after(:create) { |cart| create_list(:cart_item, 10, cart: cart) }
  end

  trait :cart_with_products do
    identifier { '11111111' }

    after(:create) { |cart| create_list(:cart_item, 2, cart: cart) }
  end
end
