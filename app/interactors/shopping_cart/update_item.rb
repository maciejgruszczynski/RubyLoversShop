class ShoppingCart
  class UpdateItem
    include Dry::Monads[:result]

    def call(cart:, product_id:, quantity:)
      cart = Entities::Cart.new(cart)
      cart_item = cart.find_item(product_id: product_id)

      new_quantity = quantity.to_i + cart_item.quantity.to_i
      cart.update_item(item: cart_item, quantity: new_quantity)

      cart_item = cart.find_item(product_id: product_id)

      if cart_item.valid?
        Success(cart)
      else
        Failure(message: errors(item: cart_item))
      end
    end

    private

    def errors(item:)
      errors = []
      errors << item.validation_errors if item.validation_errors
    end
  end
end
