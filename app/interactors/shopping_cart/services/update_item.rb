class ShoppingCart
  module Services
    class UpdateItem
      include Dry::Monads[:result]

      def call(current_cart:, product_id:, quantity:)
        current_quantity = current_cart.storage[product_id].to_i
        new_quantity = quantity.to_i + current_quantity

        cart_item = Entities::CartItem.new(product_id: product_id, quantity: new_quantity)

        if cart_item.valid?
          result = ShoppingCart::Storage.new(current_cart).update_item(product_id: product_id, quantity: new_quantity)
        else
          Failure(message: cart_item.validation_errors)
        end
      end
    end
  end
end