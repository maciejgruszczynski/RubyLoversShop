class Cart
  module Validators
    class CartMacItemsCount
      include Dry::Monads[:result]

      MAX_ITEMS_COUNT = 10

      def validate(cart)
        if cart.size <= MAX_ITEMS_COUNT
          Success
        else
          Failure(message: (I18n.t('services.errors.max_products_count', limit: MAX_ITEMS_COUNT)))
        end
      end
    end
  end
end
