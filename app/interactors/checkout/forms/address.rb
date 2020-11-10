class Checkout
  module Forms
    class Address < Base
      attr_accessor :first_name, :last_name, :address_line, :city, :postal_code, :phone_number

      validates :first_name,   presence: true
      validates :last_name,    presence: true
      validates :address_line, presence: true
      validates :city,         presence: true
      validates :postal_code,  presence: true
      validates :phone_number, presence: true

      def initialize(attributes = {})
        #step_attributes = attributes[:checkout]['address'] || attributes

        @first_name   = attributes['first_name']
        @last_name    = attributes['last_name']
        @address_line = attributes['address_line']
        @city         = attributes['city']
        @postal_code  = attributes['postal_code']
        @phone_number = attributes['phone_number']
      end
    end
  end
end
