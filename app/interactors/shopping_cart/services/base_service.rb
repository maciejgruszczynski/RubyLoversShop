class ShoppingCart
  module Services
    class BaseService
      attr_accessor :errors

      def initialize
        @errors = { cart_message: nil, items: { ids: [], message: nil } }
      end

      def add_errors(*objects)
        objects.each do |object|
          cart_error(object) if object.is_a? ShoppingCart::Entities::Cart
          cart_item_error(object) if object.is_a? ShoppingCart::Entities::CartItem
        end
      end

      private

      def cart_error(object)
        errors[:cart_message] = object.errors
      end

      def cart_item_error(object)
        errors[:items][:ids] << object.product_id
        errors[:items][:message] ||= object.errors
      end
    end
  end
end
