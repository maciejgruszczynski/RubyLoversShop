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
end

