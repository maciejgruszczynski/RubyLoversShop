class Checkout
  module Steps
    class Base

      def view_template
        name
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
        #Forms::Address
      end
    end
  end
end
