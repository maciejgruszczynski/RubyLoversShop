FactoryBot.define do
  factory(:cart) do
    sequence(:identifier, (100000..100100).cycle) {|n| n}
    value_cents { 0 }
    value_currency { 'USD' }

    trait :not_empty do
      value_cents { 1000 }
    end
  end
end
