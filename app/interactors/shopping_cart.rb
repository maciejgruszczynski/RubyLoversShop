class ShoppingCart
  include Dry::Monads[:result]

  attr_reader :storage

  def initialize(session)
    #@storage = session[:cart] ||= {}
    @storage = Entities::Storage.new(session: session)
  end

  def add_item(product_id:, quantity:)
    result = ShoppingCart::Services::AddItem.new.call(
      current_cart: storage,
      product_id: product_id,
      quantity: quantity
    )
  end

  def update_item(product_id:, quantity: )
    result = ShoppingCart::Services::UpdateItem.new.call(
      current_cart: storage,
      product_id: product_id,
      quantity: quantity
    )
  end

  def update_cart(items_after_update: )
    result = ShoppingCart::Services::UpdateCart.new.call(
      current_cart: storage,
      items_after_update: items_after_update
    )
  end

  def destroy
    result = ShoppingCart::Services::DestroyCart.new.call(current_cart: storage)
  end

  def items
    @storage.items
  end

  def number_of_items
    @storage.number_of_items
  end

  def value
    @storage.value
  end

  def destroy_item(product_id: )
    result = ShoppingCart::Services::RemoveItem.new.call(
      current_cart: storage,
      product_id: product_id
    )
  end
end
