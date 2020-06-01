class ShoppingCart
  class Store
    CART_KEY = :cart

    attr_reader :content, :errors

    def initialize(session: )
      @content = session[CART_KEY] ||= {}
      @errors = ''
    end

    def add_item(item: )
      content[item.product_id] = item.quantity
    end

    def clear
      content.clear
    end

    def remove_item(product_id:)
      content.delete(product_id.to_s)
    end

    def items
      content.map {|product_id, quantity| Entities::CartItem.new(product_id: product_id, quantity: quantity)}
    end

    def has_product?(product_id:)
      content.has_key?(product_id.to_s)
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
      validation = Validators::CartMaxItemsCount.new.validate(self.content)
      self.errors = validation.failure
      validation.success?
    end

    private

    attr_writer :errors
  end
end
