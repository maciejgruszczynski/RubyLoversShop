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
      attr_accessor :address

      def name
        'address'
      end

      def form
        Checkout::Forms::Address
      end
    end

    class DeliveryMethod < Base
      attr_accessor :delivery_method

      def name
        'delivery_method'
      end

      def form
        Checkout::Forms::DeliveryMethod
      end
    end
  end
end
