class ShoppingCart
  module Services
    class UpdateItem < BaseService
      include Dry::Monads[:result]

      def call(store:, product_id:, quantity:)
        current_quantity = store.content[product_id].to_i
        new_quantity = quantity.to_i + current_quantity

        cart_item = Entities::CartItem.new(product_id: product_id, quantity: new_quantity)

        if cart_item.valid?
          store.add_item(item: cart_item)
          Success(store)
        else
          add_errors(item: cart_item)
          Failure(message: errors)
        end
      end
    end
  end
end
