class ShoppingCart
  module Services
    class UpdateCart
      include Dry::Monads[:result]

      def call(storage:, product_id:, quantity:)

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
