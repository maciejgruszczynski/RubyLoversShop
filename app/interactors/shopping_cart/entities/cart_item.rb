class ShoppingCart
  module Entities
    class CartItem
      attr_accessor :product_id, :quantity
      attr_reader :errors

      def initialize(product_id:, quantity: )
        @product_id = product_id
        @quantity = quantity
        @errors = ''
      end

      def valid?
        validation = Validators::CartItemQuantity.new.validate(self)
        self.errors = validation.failure
        validation.success?
      end

      private

      attr_writer :errors
    end
  end
end
