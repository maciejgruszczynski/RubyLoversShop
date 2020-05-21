class ShoppingCart
  module Services
    class DestroyCart
      include Dry::Monads[:result]

      def call(cart: )
        ShoppingCart::Store.new(cart).clear_cart
        Success(cart)
      end
    end
  end
end
