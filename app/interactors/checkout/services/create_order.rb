# frozen_string_literal: true

class Checkout
  module Services
    class CreateOrder
      include Dry::Monads[:result]

      def call(form)
        order = Order.new(
          identifier: form.identifier,
          delivery_method: form.delivery_method,
          final_price_net_cents: form.final_price_net_cents,
          final_price_net_currency: form.final_price_net_currency,
          customer_email: form.customer_email
        )

        if order.save!
          Success(order)
        end
      end
    end
  end
end
