class ShoppingCart
  module Services
    class RemoveItem
      include Dry::Monads[:result]

      def call(current_cart:, product_id:)
        current_cart.storage.delete(product_id)
        Success(current_cart)
      end
    end
  end
end
