class ShoppingCart
  module Entities
    class Cart
      attr_accessor :storage
      attr_reader :errors, :store

      def initialize(session:)
        @storage = session[:cart] ||= {}
        @store = ShoppingCart::Store.new(self)
        @errors = ''
      end

      def items
        storage.map {|product_id, quantity| CartItem.new(product_id: product_id, quantity: quantity)}
      end

      def has_product?(product_id:)
        storage.has_key?(product_id.to_s)
      end

      def product(product_id:)
        Product.find(product_id)
      end

      def items_count
        items.count
      end

      def value
        items.map { |item| item.quantity.to_i * product(product_id: item.product_id).price}.sum
      end

      def valid?
        validation = Validators::CartMaxItemsCount.new.validate(self.storage)
        self.errors = validation.failure
        validation.success?
      end

      private

      attr_writer :errors
    end
  end
end
