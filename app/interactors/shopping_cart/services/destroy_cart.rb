class ShoppingCart
  module Services
    class DestroyCart
      include Dry::Monads[:result]

      def call(cart: )
        cart.store.clear_cart
        Success(cart)
      end
    end
  end
end
