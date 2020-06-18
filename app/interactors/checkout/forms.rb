class Checkout
  module Forms
    class Base
      include ActiveModel::Model

    end

    class Address < Base
      attr_accessor :address

    end

    class DeliveryMethod < Base
      attr_accessor :delivery_method

    end
  end
end
