class ShoppingCart
  module Services
    class AddItem
      include Dry::Monads[:result]

      def call(cart:, product_id:, quantity:)
        cart_item = Entities::CartItem.new(product_id: product_id, quantity: quantity)

        if cart.valid?
          if cart_item.valid?
            ShoppingCart::Store.new(cart).add_item(item: cart_item)
            Success(cart)
          else
            Failure(message: cart_item.errors)
          end
        else
          Failure(message: cart.errors)
        end
      end
    end
  end
end
