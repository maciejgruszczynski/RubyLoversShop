class AddPriceToProduct < ActiveRecord::Migration[6.0]
  def change
    add_monetize :products, :price

    Product.find_each do |product|
      product.update(price_cents: rand(1000), price_currency: "USD")
    end
  end
end
