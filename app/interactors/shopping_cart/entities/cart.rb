class ShoppingCart
  module Entities
    class Cart
      include Dry::Monads[:result]

      def initialize(cart)
        @cart = cart
      end

      def add_item(item)
        cart[item.product_id] = item.quantity
      end

      def valid?
        validation = Validators::CartItemQuantity.new.validate(self)
        validation.success?
      end

      def validation_errors
        validation = Validators::CartItemQuantity.new.validate(self)
        validation.failure
      end

      private

      attr_accessor :cart
    end
  end
end
