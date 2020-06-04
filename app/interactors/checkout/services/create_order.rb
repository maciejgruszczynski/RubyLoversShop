class Checkout
  module Services
    class CreateOrder
      def call(cart: )
        Order.create!(
          final_price_net_cents: cart.value
        )
      end
    end
  end
end
