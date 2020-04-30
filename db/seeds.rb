require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation)

puts "Creating products"

initial_product_code = "000000"
(1..30).each do |i|
  Product.new(
    name: "Shirt_#{i}",
    description: "Description of shirt_#{i}",
    code: initial_product_code.next!,
    price_cents: rand(1000),
    price_currency: "USD"
  ).save
end

puts "Products created"

puts "Creating users"

default_password = 'password'
User.create(email: 'user1@test.pl', password: default_password, password_confirmation: default_password)
User.create(email: 'user2@test.pl', password: default_password, password_confirmation: default_password)

puts "Users created"
