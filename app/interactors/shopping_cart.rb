require 'active_support/core_ext/module/delegation'

class ShoppingCart
  include Dry::Monads[:result]

  attr_reader :cart

  def initialize(session)
    @cart = Entities::Cart.new(session: session)
  end

  delegate :items, :count_items, :has_product?, :product, :value, to: :cart

  def add_item(product_id:, quantity:)
    ShoppingCart::Services::AddItem.new.call(
      cart: cart,
      product_id: product_id,
      quantity: quantity
    )
  end

  def update_item(product_id:, quantity: )
    ShoppingCart::Services::UpdateItem.new.call(
      cart: cart,
      product_id: product_id,
      quantity: quantity
    )
  end

  def update_cart(items_after_update: )
    ShoppingCart::Services::UpdateCart.new.call(
      cart: cart,
      items_after_update: items_after_update
    )
  end

  def destroy
    ShoppingCart::Services::DestroyCart.new.call(cart: cart)
  end

  def remove_item(product_id: )
    ShoppingCart::Services::RemoveItem.new.call(
      cart: cart,
      product_id: product_id
    )
  end
end
