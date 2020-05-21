class ShoppingCart
  module Services
    class RemoveItem
      include Dry::Monads[:result]

      def call(cart:, product_id:)
        ShoppingCart::Store.new(cart).remove_item(product_id: product_id)
        Success(cart)
      end
    end
  end
end
