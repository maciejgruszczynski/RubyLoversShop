class Checkout
  module Forms
    class PaymentInfo < Base
      attr_accessor :customer_email

      validates :customer_email, presence: true

      def initialize(attributes = {})
        @customer_email = attributes['customer_email']
      end
    end
  end
end
