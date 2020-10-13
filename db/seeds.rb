require 'database_cleaner'

if Rails.env.development?
  DatabaseCleaner.clean_with(:truncation)

  puts 'Creating products'

  initial_product_code = '000000'
  (1..30).each do |i|
    Product.new(
      name: "Shirt_#{i}",
      description: "Description of shirt_#{i}",
      code: initial_product_code.next!,
      price_cents: rand(1000),
      price_currency: 'USD'
    ).save
  end

  puts 'Products created'

  puts 'Creating delivery methods'

  DeliveryMethod.create!(name: 'DHL')
  DeliveryMethod.create!(name: 'Inpost')

  puts 'Delivery methods created'

  puts 'Creating orders'

  Order.create!(final_price_net_cents: 1000, final_price_net_currency: "USD", delivery_method: 'DHL',
                identifier: rand(1000..9999), customer_email: "test_1@example.com", state: "new")

  Order.create!(final_price_net_cents: 1000, final_price_net_currency: "USD", delivery_method: 'DHL',
                identifier: rand(1000..9999), customer_email: "test_2@example.com", state: "with_customer_data")

  Order.create!(final_price_net_cents: 1000, final_price_net_currency: "USD", delivery_method: 'DHL',
                identifier: rand(1000..9999), customer_email: "test_3@example.com", state: "with_delivery_method")

  Order.create!(final_price_net_cents: 1000, final_price_net_currency: "USD", delivery_method: 'DHL',
                identifier: rand(1000..9999), customer_email: "test_4@example.com", state: "waiting_for_payment")

  Order.create!(final_price_net_cents: 1000, final_price_net_currency: "USD", delivery_method: 'DHL',
                identifier: rand(1000..9999), customer_email: "test_5@example.com", state: "paid")

  puts 'Orders created'
end
