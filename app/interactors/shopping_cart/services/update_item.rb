class ShoppingCart
  module Services
    class UpdateItem
      include Dry::Monads[:result]

      def call(cart:, product_id:, quantity:)
        cart = Cart.new(cart)
        cart_item = cart.find_item(product_id: product_id)

        new_quantity = quantity.to_i + cart_item.quantity.to_i
        cart_item.quantity = new_quantity

        if cart_item.valid?
          cart.update_item(item: cart_item, quantity: new_quantity)
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
end
