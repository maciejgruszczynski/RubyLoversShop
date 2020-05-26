class ShoppingCart
  module Services
    class AddItem < BaseService
      include Dry::Monads[:result]

      def call(cart:, product_id:, quantity:)
        cart_item = Entities::CartItem.new(product_id: product_id, quantity: quantity)

        if cart.valid? && cart_item.valid?
          cart.store.add_item(item: cart_item)
          Success(cart)
        else
          add_errors(cart, cart_item)
          Failure(message: errors)
        end
      end
    end
  end
end
