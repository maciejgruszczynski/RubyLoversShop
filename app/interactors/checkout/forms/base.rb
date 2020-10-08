class Checkout
  module Forms
    class Base
      include ActiveModel::Model

      def verify_presence_of_attributes(attributes)
        raise ArgumentError if attributes.nil?
      end
    end
  end
end
