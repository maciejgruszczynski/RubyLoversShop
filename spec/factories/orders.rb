FactoryBot.define do
  factory(:order) do
    identifier { 'AA111' }
    delivery_method { 'DHL' }
    customer_email { 'customer@email.com' }
    final_price_net_cents { 10000 }
    final_price_net_currency { 'USD' }
  end
end