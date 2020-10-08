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
    end

    class Address < Base
      def name
        'address'
      end

      def form
        Checkout::Forms::Address
      end
    end

    class DeliveryMethod < Base
      def name
        'delivery_method'
      end

      def form
        Checkout::Forms::DeliveryMethod
      end
    end

    class Payment < Base
      def name
        'payment'
      end

      def form
        Checkout::Forms::Payment
      end
    end

    class OrderSummary < Base
      def name
        'summary'
      end
    end
  end
end
