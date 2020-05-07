class AddCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.integer   :cart_id
      t.integer   :product_id
      t.text      :product_code
      t.text      :product_name
      t.integer   :quantity
      t.monetize  :unit_price
      t.monetize  :final_price

      t.timestamps
    end

    add_foreign_key :cart_items, :carts
    add_foreign_key :cart_items, :products
  end
end
