class Checkout
  module OrderForm
    class Base
      include ActiveModel::Model

      attr_accessor :order, :current_step

      def initialize
        @order = Order.new
      end
    end

    class Step1 < Base
      attr_accessor :shippment_method
    end

    class Step2 < Step1
      attr_accessor :step2
    end
  end
end
