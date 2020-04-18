FactoryBot.define do
  factory(:cart) do
    sequence(:identrifier, (100000..100100).cycle) {|n| n}
    value_cents { 0 }
    value_currency { 'USD' }

    trait :empty do

    end
  end
end
