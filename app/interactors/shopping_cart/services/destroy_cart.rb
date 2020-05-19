class ShoppingCart
  module Services
    class DestroyCart
      include Dry::Monads[:result]

      def call(current_cart: )
        current_cart.storage.clear
        Success(current_cart)
      end
    end
  end
end
