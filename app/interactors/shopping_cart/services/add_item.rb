class ShoppingCart
  module Services
    class AddItem
      include Dry::Monads[:result]

      def call(current_cart:, product_id:, quantity:)
        cart_item = Entities::CartItem.new(product_id: product_id, quantity: quantity)

        if current_cart.valid? && cart_item.valid?
          ShoppingCart::Store.new(current_cart).add_item(item: cart_item)
          Success(current_cart)
        else
          Failure(message: errors(cart: current_cart, item: cart_item))
        end
      end

      private

      def errors(cart:, item: )
        errors = []
        errors << cart.errors if cart.errors.present?
        errors << item.errors if item.errors.present?
        errors
      end
    end
  end
end
