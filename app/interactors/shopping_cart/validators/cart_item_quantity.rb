class ShoppingCart
  module Validators
    class CartItemQuantity
      include Dry::Monads[:result]

      MAX_QUANTITY = 5

      def validate(item)
        if item.quantity.to_i <= MAX_QUANTITY
          Success(item)
        else
          Failure(I18n.t('services.errors.max_quantity', limit: MAX_QUANTITY))
        end
      end
    end
  end
end
