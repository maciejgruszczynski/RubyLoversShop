class ShoppingCart
  class AddItem
    include Dry::Monads[:result]
    #attr_reader :cart
#
#    def initialize(cart)
#      @cart = cart
#    end

    def call(cart:, product_id:, quantity:)
      cart_item = Entities::CartItem.new(product_id: product_id, quantity: quantity)
      #cart[cart_item.product_id] = cart_item.quantity
      cart = Entities::Cart.new(cart)
      cart.add_item(cart_item)

      if cart_item.valid?
        Success(cart)
      else
        Failure(message: errors(item: cart_item, cart: cart_item))
      end
    end

    private

    def errors(item:, cart:)
      errors = []
      errors << item.validation_errors
      errors << item.validation_errors
      errors
    end
  end
end
