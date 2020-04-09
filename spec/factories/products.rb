FactoryBot.define do
  factory :product do
    name { 'product' }
    description { 'description' }
    code { '123456' }
    price_cents { 1000 }
    price_currency { 'USD' }
  end
end
