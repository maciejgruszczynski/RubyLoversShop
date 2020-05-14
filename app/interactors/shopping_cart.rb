class ShoppingCart
  include Dry::Monads[:result]

  attr_reader :cart

  def initialize(session)
    @cart = session[:cart] ||= {}
  end

  def add_item(product_id:, quantity:)
    result = ShoppingCart::Services::AddItem.new.call(cart: cart, product_id: product_id, quantity: quantity)

    if result.success?
      Success(cart)
    else
      Failure(result.failure)
    end
  end

  def update_item(product_id:, quantity: )
    result = ShoppingCart::Services::UpdateItem.new.call(cart: cart, product_id: product_id, quantity: quantity)

    if result.success?
      Success(cart)
    else
      Failure(result.failure)
    end
  end

  def update_cart(items_after_update: )
    result = ShoppingCart::Services::UpdateCart.new.call(cart: cart, items_after_update: items_after_update)
  end

  def destroy
    cart.clear
  end

  #def find_item(product_id: )
  #  ShoppingCart::Cart.new(cart).find_item(product_id: product_id)
  #end
end
