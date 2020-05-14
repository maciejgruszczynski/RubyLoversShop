class ShoppingCart
  include Dry::Monads[:result]

  attr_reader :storage

  def initialize(session)
    @storage = session[:cart] ||= {}
  end

  def add_item(product_id:, quantity:)
    result = ShoppingCart::Services::AddItem.new.call(
      storage: storage,
      product_id: product_id,
      quantity: quantity
    )
  end

  def update_item(product_id:, quantity: )
    result = ShoppingCart::Services::UpdateItem.new.call(
      storage: storage,
      product_id: product_id,
      quantity: quantity
    )
  end

  def update_cart(items_after_update: )
    result = ShoppingCart::Services::UpdateCart.new.call(
      storage: storage,
      items_after_update: items_after_update
    )
  end

  def destroy
    storage.clear
  end

  def find_item(product_id: )
    ShoppingCart::Storage.new(storage).find_item(product_id: product_id)
  end

  def items
    @storage
  end

  def destroy_item(product_id: )
    result = ShoppingCart::Services::RemoveItem.new.call(
      storage: storage,
      product_id: product_id
    )
  end
end
