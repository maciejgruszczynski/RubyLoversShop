class ShoppingCart
  module Services
    class UpdateCart
      include Dry::Monads[:result]

      def call(current_cart:, items_after_update:)
        items = []

        items_after_update.each do |item|
          product_id = item[0]
          quantity = item.dig(1, :quantity).to_i

          items << Entities::CartItem.new(product_id: product_id, quantity: quantity)
        end

        if items.all? { |item| item.valid? }
          result = ShoppingCart::Storage.new(current_cart).update_cart(items_after_update: items)
        else
          Failure(message: items.select { |item| !item.valid? }.first.validation_errors)
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
