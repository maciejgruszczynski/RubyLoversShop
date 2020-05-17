class ShoppingCart
  module Services
    class AddItem
      include Dry::Monads[:result]

      def call(current_cart:, product_id:, quantity:)
        cart_item = Entities::CartItem.new(product_id: product_id, quantity: quantity)

        if cart_item.valid?
          result = ShoppingCart::Storage.new(current_cart).add_item(cart_item)
        else
          Failure(message: cart_item.validation_errors)
        end
      end
    end
  end
end
