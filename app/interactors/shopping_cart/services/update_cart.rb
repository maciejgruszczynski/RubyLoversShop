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
          items.each do |item|
            current_cart.storage[item.product_id] = item.quantity
          end
          Success(current_cart)
        else
          Failure(message: items.select { |item| !item.valid? }.first.validation_errors)
        end
      end
    end
  end
end
