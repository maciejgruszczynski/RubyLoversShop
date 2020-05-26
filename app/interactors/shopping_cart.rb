require 'active_support/core_ext/module/delegation'

class ShoppingCart
  include Dry::Monads[:result]

  attr_reader :cart

  def initialize(session)
    @cart = Entities::Cart.new(session: session)
  end

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

  def items
    cart.items
  end

  def count_items
    cart.count_items
  end

  def has_product?(product_id: )
    cart.has_product?(product_id: product_id)
  end

  def product(product_id:)
    cart.product(product_id: product_id)
  end

  def value
    cart.value
  end
end
