class ShoppingCart
  module Entities
    class Cart
      include Dry::Monads[:result]

      def initialize(cart)
        @cart = cart
      end

      def find_item(product_id: )
        item_attributes = cart.select { |key| key == product_id }
        Entities::CartItem.new(product_id: item_attributes.keys.first, quantity: item_attributes[product_id])
      end

      def add_item(item)
        cart[item.product_id] = item.quantity

        if item.valid?
          Success(cart)
        else
          Failure(item.validation_errors)
        end
      end

      def update_item(item:, quantity:)
        current_quantity = cart[item.product_id].to_i
        new_quantity = current_quantity + quantity.to_i

        cart[item.product_id] = item.new_quantity

        if item.valid?
          Success(cart)
        else
          Failure(item.validation_errors)
        end
      end

      def valid?
        validation = Validators::CartMaxItemsCount.new.validate(cart)
        validation.success?
      end

      def validation_errors
        validation = Validators::CartMaxItemsCount.new.validate(cart)
        validation.failure
      end


      private

      attr_accessor :cart
    end
  end
end
