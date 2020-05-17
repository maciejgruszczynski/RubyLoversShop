class ShoppingCart
  module Services
    class RemoveItem
      include Dry::Monads[:result]

      def call(current_cart:, product_id:)
        result = ShoppingCart::Storage.new(current_cart).remove_item(product_id: product_id)
      end
    end
  end
end
