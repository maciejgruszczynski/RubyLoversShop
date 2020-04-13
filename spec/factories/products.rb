FactoryBot.define do
  factory(:product) do
    factory :shirt do
      sequence(:name) { |n| "Shirt_#{n}" }
      description { 'description' }
      sequence(:code, (100000..100100).cycle) {|n| n}
      price_cents { 1000 }
      price_currency { 'USD' }
    end

    factory :shoes do
      sequence(:name) { |n| "Shoes_#{n}" }
      description { 'description' }
      sequence(:code, (200000..200100).cycle) {|n| n}
      price_cents { 1000 }
      price_currency { 'USD' }
    end
  end
end
