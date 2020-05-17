class ShoppingCart
  module Entities
    class CartItem

      attr_accessor :product_id, :quantity

      def initialize(product_id:, quantity: )
        @product_id = product_id
        @quantity = quantity
      end

      def valid?
        validation = Validators::CartItemQuantity.new.validate(self)
        validation.success?
      end

      def validation_errors
        validation = Validators::CartItemQuantity.new.validate(self)
        validation.failure
      end
    end
  end
end
