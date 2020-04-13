puts "Creating products"

initial_product_code = "000000"
(1..10).each do |i|
  Product.new(
    name: "Shirt_#{i}",
    description: "Description of shirt_#{i}",
    code: initial_product_code.next!,
    price_cents: rand(1000),
    price_currency: "USD"
  ).save
end

puts "Products created"
