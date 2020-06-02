class ShoppingCart
  module Services
    class AddItem < BaseService
      include Dry::Monads[:result]

      def call(store:, product_id:, quantity:)
        cart_item = Entities::CartItem.new(product_id: product_id, quantity: quantity)

        if store.valid? && cart_item.valid?
          store.add_item(item: cart_item)
          Success(store)
        else
          add_errors(store: store, item: cart_item)
          Failure(message: errors)
        end
      end
    end
  end
end
