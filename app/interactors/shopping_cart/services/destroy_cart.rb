class ShoppingCart
  module Services
    class DestroyCart
      include Dry::Monads[:result]

      def call(current_cart: )
        ShoppingCart::Store.new(current_cart).clear_cart
        Success
      end
    end
  end
end
