class ShoppingCart
  module Services
    class UpdateItem
      include Dry::Monads[:result]

      def call(storage:, product_id:, quantity:)
        storage = Storage.new(storage)
        cart_item = storage.find_item(product_id: product_id)

        new_quantity = quantity.to_i + cart_item.quantity.to_i
        cart_item.quantity = new_quantity

        if cart_item.valid?
          storage.update_item(item: cart_item, quantity: new_quantity)
          Success(storage)
        else
          Failure(message: errors(item: cart_item))
        end
      end

      private

      def errors(item:)
        errors = []
        errors << item.validation_errors if item.validation_errors
      end
    end
  end
end
