class Checkout
  module Steps
    class Base
      def name
        raise NotImplementedError
      end

      def form
        raise NotImplementedError
      end

      def view_template
        name
      end

      def render_step(step)
        step
      end

      def update_order(form)
        true
      end
    end

    class Address < Base
      def initialize(checkout = nil)
        @checkout = checkout
      end

      def name
        'address'
      end

      def form
        Checkout::Forms::Address
      end

      def update_order(form)
        checkout.order.fill_with_customer_data!
      end

      private

      attr_reader :checkout
    end

    class DeliveryMethod < Base
      def initialize(checkout = nil)
        @checkout = checkout
      end

      def name
        'delivery_method'
      end

      def form
        Checkout::Forms::DeliveryMethod
      end

      def update_order(form)
        checkout.order.update(delivery_method: form.name)
        checkout.order.fill_with_delivery_method!
      end

      private

      attr_reader :checkout
    end

    class PaymentInfo < Base
      def initialize(checkout = nil)
        @checkout = checkout
      end

      def name
        'payment_info'
      end

      def form
        Checkout::Forms::PaymentInfo
      end

      def update_order(form)
        checkout.order.update(customer_email: form.customer_email)
        checkout.order.fill_with_payment_info!
      end

      private

      attr_reader :checkout
    end

    class Payment < Base
      def initialize(checkout = nil)
        @checkout = checkout
      end

      def name
        'payment'
      end

      def form
        Checkout::Forms::Payment
      end

      def update_order(form)
        checkout.order.pay!
      end

      private

      attr_reader :checkout
    end

    class OrderSummary < Base
      def name
        'summary'
      end
    end
  end
end
