class Checkout
  module Steps
    class Base
      def name
        raise NotImplementedError
      end

      def view_template
        name
      end
    end
  end
end

class Checkout
  module Steps
    class Address < Base
      def name
        'address'
      end

      def form
        Forms::Address
      end
    end
  end
end

class Checkout
  module Steps
    class Delivery < Base
      def name
        'delivery'
      end
    end
  end
end
