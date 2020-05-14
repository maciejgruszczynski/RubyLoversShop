class ShoppingCart
  class Cart
    include Dry::Monads[:result]

    attr_accessor :cart

    def initialize(cart)
      @cart = cart
    end

    def find_item(product_id: )
      item_attributes = cart.select { |key| key == product_id.to_s }
      Entities::CartItem.new(product_id: item_attributes.keys.first, quantity: item_attributes[product_id.to_s])
    end

    def add_item(item)
      if item.valid?
        cart[item.product_id] = item.quantity
        if self.valid?
          Success(cart)
        else
          Failure(self.validation_errors)
        end
      else
        Failure(item.validation_errors)
      end
    end

    def update_item(item:, quantity:)
      cart[item.product_id] = quantity
      Success(cart)
    end

    def valid?
      validation = Validators::CartMaxItemsCount.new.validate(cart)
      validation.success?
    end

    def validation_errors
      validation = Validators::CartMaxItemsCount.new.validate(cart)
      validation.failure
    end
  end
end
