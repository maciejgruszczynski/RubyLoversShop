class ShoppingCart
  module Services
    class DestroyCart
      include Dry::Monads[:result]

      def call(store: )
        store.clear
        Success(store)
      end
    end
  end
end
