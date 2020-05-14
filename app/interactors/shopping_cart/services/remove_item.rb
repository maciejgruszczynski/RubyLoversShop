class ShoppingCart
  module Services
    class RemoveItem
      include Dry::Monads[:result]

      def call(storage:, product_id:)
        storage = Storage.new(storage)
        storage.items.delete(product_id.to_s)

        Success(storage)
      end
    end
  end
end
