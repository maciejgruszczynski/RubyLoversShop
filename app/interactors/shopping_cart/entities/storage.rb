class ShoppingCart
  module Entities
    class Storage

      attr_accessor :storage

      def initialize(session:)
        @storage = session[:cart] ||= {}
      end

      def items
        storage
      end

      def has_product?(product_id:)
        storage.has_key?(product_id.to_s)
      end

      def find_item(product_id:)
        storage[produt_id]
      end


      def product(product_id:)
        Product.find(product_id)
      end

      def number_of_items
        storage.size
      end

      def value
        value = 0

        items.each do |product_id, quantity|
          product = product(product_id: product_id)
          value += quantity.to_i * product.price
        end

        value
      end

      def valid?
        validation = Validators::CartMaxItemsCount.new.validate(self)
        validation.success?
      end

      def validation_errors
        validation = Validators::CartMaxItemsCount.new.validate(self)
        validation.failure
      end
    end
  end
end
