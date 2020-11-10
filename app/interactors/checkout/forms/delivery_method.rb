class Checkout
  module Forms
    class DeliveryMethod < Base
      attr_accessor :name

      validates :name, presence: true,
                         inclusion: { in: :allowed_delivery_methods }

      def initialize(attributes = {})
        #step_attributes = attributes[:checkout]['address']

        @name  = attributes['name']
      end

      private

      def allowed_delivery_methods
        ::DeliveryMethod.all.pluck(:name)
      end
    end
  end
end
