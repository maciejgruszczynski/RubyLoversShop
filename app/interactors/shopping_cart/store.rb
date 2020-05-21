class ShoppingCart
  class Store

    attr_reader :storage

    def initialize(storage)
      @storage = storage
    end

    def add_item(item: )
      storage.storage[item.product_id] = item.quantity
    end

    def clear_cart
      storage.storage.clear
    end
  end
end
