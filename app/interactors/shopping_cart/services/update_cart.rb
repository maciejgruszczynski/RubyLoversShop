class ShoppingCart
  module Services
    class UpdateCart < BaseService
      include Dry::Monads[:result]

      def call(store:, items_after_update:)
        items = []

        items_after_update.each do |item|
          product_id = item[0]
          quantity = item.dig(1, "quantity").to_i

          items << Entities::CartItem.new(product_id: product_id, quantity: quantity)
        end

        if items.all? { |item| item.valid? }
          items.each do |item|
            store.add_item(item: item)
          end
          Success(store)
        else
          invalid_items = items.select { |item| !item.valid? }

          invalid_items.each do |item|
            add_errors(item: item)
          end
          Failure(message: errors)
        end
      end
    end
  end
end
