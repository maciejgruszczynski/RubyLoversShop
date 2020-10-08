class Checkout
  class OrderSummary
    attr_reader :address, :delivery_method, :payment, :cart

    def initialize(checkout:, cart:)
      @address = Forms::Address.new(checkout['address'])
      @delivery_method = Forms::DeliveryMethod.new(checkout['delivery_method'])
      @payment = Forms::Payment.new(checkout['payment'])
      @cart = cart
    end
  end
end
