class ShoppingCart
  class Store

    attr_reader :cart

    def initialize(cart)
      @cart = cart
    end

    def add_item(item: )
      cart.storage[item.product_id] = item.quantity
    end

    def clear_cart
      cart.storage.clear
    end

    def remove_item(product_id:)
      cart.storage.delete(product_id.to_s)
    end
  end
end
