class ShoppingCart
  module Services
    class UpdateCart
      include Dry::Monads[:result]

      def call(cart:, product_id:, quantity:)

      end

      private

      def errors(item:, cart:)
        errors = []
        errors << item.validation_errors if item.validation_errors
        errors << cart.validation_errors if cart.validation_errors
        errors
      end
    end
  end
end
