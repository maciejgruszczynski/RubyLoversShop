class ShoppingCart
  module Services
    class BaseService
      attr_accessor :errors

      def initialize
        @errors = { cart_message: nil, items: { ids: [], message: nil } }
      end

      def add_errors(store: nil, item: nil)
        if store.present? && !store.valid?
          errors[:cart_message] = store.errors
        end

        if item.present? && !item.valid?
          errors[:items][:ids] << item.product_id
          errors[:items][:message] ||= item.errors
        end
      end
    end
  end
end
