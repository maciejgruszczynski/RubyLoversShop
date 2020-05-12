class ShoppingCart
  include Dry::Monads[:result]

  attr_reader :cart

  def initialize(session)
    @cart = session[:cart] ||= {}
  end

  def add_item(product_id:, quantity:)
    result =
      if cart.has_key?(product_id)
        ShoppingCart::UpdateItem.new.call(cart: cart, product_id: product_id, quantity: quantity)
      else
        ShoppingCart::AddItem.new.call(cart: cart, product_id: product_id, quantity: quantity)
      end

    if result.success?
      Success(cart)
    else
      Failure(result.failure)
    end
  end

  def update_cart(items_after_update: )
    result = ShoppingCart::UpdateCart.new.call(cart: cart, items_after_update: items_after_update)
  end

  def destroy
    cart.clear
  end
end
