class ShoppingCart
  module Services
    class AddItem
      include Dry::Monads[:result]

      def call(storage:, product_id:, quantity:)
        cart_item = Entities::CartItem.new(product_id: product_id, quantity: quantity)

        storage = Storage.new(storage)

        if cart_item.valid? && storage.add_item(cart_item).success?
          Success(storage)
        else
          Failure(message: errors(item: cart_item, storage: storage))
        end
      end

      private

      def errors(item:, storage:)
        errors = []
        errors << item.validation_errors if item.validation_errors
        errors << storage.validation_errors if storage.validation_errors
        errors
      end
    end
  end
end
