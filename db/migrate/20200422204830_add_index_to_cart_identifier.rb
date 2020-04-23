class AddIndexToCartIdentifier < ActiveRecord::Migration[6.0]
  def change
    add_index :carts, :identifier, unique: true
  end
end
