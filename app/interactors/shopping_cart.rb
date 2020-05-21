require 'active_support/core_ext/module/delegation'

class ShoppingCart
  include Dry::Monads[:result]

  attr_reader :storage

  def initialize(session)
    @storage = Entities::Storage.new(session: session)
  end

  delegate :items, :count_items, :has_product?, :value, to: :storage

  def add_item(product_id:, quantity:)
    ShoppingCart::Services::AddItem.new.call(
      current_cart: storage,
      product_id: product_id,
      quantity: quantity
    )
  end

  def update_item(product_id:, quantity: )
    ShoppingCart::Services::UpdateItem.new.call(
      current_cart: storage,
      product_id: product_id,
      quantity: quantity
    )
  end

  def update_cart(items_after_update: )
    ShoppingCart::Services::UpdateCart.new.call(
      current_cart: storage,
      items_after_update: items_after_update
    )
  end

  def destroy
    ShoppingCart::Services::DestroyCart.new.call(current_cart: storage)
  end

  def remove_item(product_id: )
    ShoppingCart::Services::RemoveItem.new.call(
      current_cart: storage,
      product_id: product_id
    )
  end
end
