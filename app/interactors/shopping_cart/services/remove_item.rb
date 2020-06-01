class ShoppingCart
  module Services
    class RemoveItem
      include Dry::Monads[:result]

      def call(store:, product_id:)
        store.remove_item(product_id: product_id)
        Success(store)
      end
    end
  end
end
