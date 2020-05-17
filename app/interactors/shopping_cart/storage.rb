class ShoppingCart
  class Storage
    include Dry::Monads[:result]

    attr_accessor :cart

    def initialize(cart)
      @cart = cart
    end

    def find_item(product_id: )
      item_attributes = storage.select { |key| key == product_id.to_s }
      Entities::CartItem.new(product_id: item_attributes.keys.first, quantity: item_attributes[product_id.to_s])
    end

    def add_item(item)
      cart.storage[item.product_id] = item.quantity
      if self.valid?
        Success(cart)
      else
        Failure(self.validation_errors)
      end
    end

    def update_item(product_id:, quantity:)
      cart.storage[product_id] = quantity
      Success(cart)
    end

    def update_cart(items_after_update:)
      items_after_update.each do |item|
        update_item(product_id: item.product_id, quantity: item.quantity)
      end
      Success(cart)
    end

    def remove_item(product_id: )
      cart.storage.delete(product_id)
      Success(cart)
    end

    def destroy_cart
      cart.storage.clear
      Success(cart)
    end

    def valid?
      validation = Validators::CartMaxItemsCount.new.validate(cart.storage)
      validation.success?
    end

    def validation_errors
      validation = Validators::CartMaxItemsCount.new.validate(cart.storage)
      validation.failure
    end
  end
end
