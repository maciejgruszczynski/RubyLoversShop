class ShoppingCart
  module Validators
    class CartMaxItemsCount
      include Dry::Monads[:result]

      MAX_ITEMS_COUNT = 10

      def validate(cart)
        if cart.size <= MAX_ITEMS_COUNT
          Success(cart)
        else
          Failure(I18n.t('services.errors.max_products_count', limit: MAX_ITEMS_COUNT))
        end
      end
    end
  end
end
