class ShoppingCart
  include Dry::Monads[:result]

  attr_reader :store

  def initialize(session)
    @store = Store.new(session: session)
  end

  def add_item(product_id:, quantity:)
    ShoppingCart::Services::AddItem.new.call(
      store: store,
      product_id: product_id,
      quantity: quantity
    )
  end

  def update_item(product_id:, quantity: )
    ShoppingCart::Services::UpdateItem.new.call(
      store: store,
      product_id: product_id,
      quantity: quantity
    )
  end

  def update_cart(items_after_update: )
    ShoppingCart::Services::UpdateCart.new.call(
      store: store,
      items_after_update: items_after_update
    )
  end

  def destroy_cart
    ShoppingCart::Services::DestroyCart.new.call(store: store)
  end

  def remove_item(product_id: )
    ShoppingCart::Services::RemoveItem.new.call(
      store: store,
      product_id: product_id
    )
  end

  def items
    store.items
  end

  def items_count
    store.items_count
  end

  def has_product?(product_id: )
    store.has_product?(product_id: product_id)
  end

  def product(product_id:)
    store.product(product_id: product_id)
  end

  def value
    store.value
  end
end
