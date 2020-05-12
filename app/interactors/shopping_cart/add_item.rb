class ShoppingCart
  class AddItem
    include Dry::Monads[:result]

    def call(cart:, product_id:, quantity:)
      cart_item = Entities::CartItem.new(product_id: product_id, quantity: quantity)

      cart = Entities::Cart.new(cart)

      #result = cart.add_item(cart_item)

      if cart_item.valid? && cart.add_item(cart_item).success?
        Success(cart)
      else
        binding.pry
        Failure(message: errors(item: cart_item, cart: cart))
      end
      #if result.success? && cart.valid?
      #  binding.pry
      #  Success(cart)
      #else
      #  Failure(message: errors(item: cart_item, cart: cart))
      #end
    end

    private

    def errors(item:, cart:)
      errors = []
      errors << item.validation_errors if item.validation_errors
      errors << cart.validation_errors if cart.validation_errors
      errors
    end
  end
end
