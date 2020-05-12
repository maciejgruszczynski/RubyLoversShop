class ShoppingCart
  include Dry::Monads[:result]

  attr_reader :cart

  def initialize(session)
    @cart = session[:cart] ||= {}
  end

  def add_item(product_id:, quantity:)
    result = ShoppingCart::AddItem.new.call(cart: cart, product_id: product_id, quantity: quantity)

    if result.success?
      Success(cart)
    else
      Failure(result.failure)
    end
  end
end
