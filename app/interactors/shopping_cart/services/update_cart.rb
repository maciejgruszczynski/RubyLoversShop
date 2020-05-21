class ShoppingCart
  module Services
    class UpdateCart
      include Dry::Monads[:result]

      def call(cart:, items_after_update:)
        items = []

        items_after_update.each do |item|
          product_id = item[0]
          quantity = item.dig(1, :quantity).to_i

          items << Entities::CartItem.new(product_id: product_id, quantity: quantity)
        end

        if items.all? { |item| item.valid? }
          items.each do |item|
            ShoppingCart::Store.new(cart).add_item(item: item)
          end
          Success(cart)
        else
          Failure(message: items.select { |item| !item.valid? }.first.errors)
        end
      end
    end
  end
end
