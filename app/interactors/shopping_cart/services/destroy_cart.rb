class ShoppingCart
  module Services
    class DestroyCart
      include Dry::Monads[:result]

      def call(current_cart: )
        result = ShoppingCart::Storage.new(current_cart).destroy_cart
      end
    end
  end
end
