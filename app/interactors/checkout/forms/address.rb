class Checkout
  module Forms
    class Address
      include ActiveModel::Model

      attr_accessor :shippment_method

      def partial_name
        'address'
      end

      def persist
        CreateOrder.new(shippment_method).save!

      end


    end
  end
end
