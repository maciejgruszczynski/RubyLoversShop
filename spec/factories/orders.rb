FactoryBot.define do
  factory(:order) do
    identifier { 'AA111' }
    delivery_method { 'DHL' }
    customer_email { 'customer@email.com' }
  end
end