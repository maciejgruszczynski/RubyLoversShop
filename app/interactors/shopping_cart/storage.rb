class ShoppingCart
  class Storage
    include Dry::Monads[:result]

    attr_accessor :storage

    def initialize(storage)
      @storage = storage
    end

    def find_item(product_id: )
      item_attributes = storage.select { |key| key == product_id.to_s }
      Entities::CartItem.new(product_id: item_attributes.keys.first, quantity: item_attributes[product_id.to_s])
    end

    def add_item(item)
      if item.valid?
        storage[item.product_id] = item.quantity
        if self.valid?
          Success(storage)
        else
          Failure(self.validation_errors)
        end
      else
        Failure(item.validation_errors)
      end
    end

    def update_item(item:, quantity:)
      storage[item.product_id] = quantity
      Success(storage)
    end

    def destroy_item(item: )
      binding.pry
    end

    def valid?
      validation = Validators::CartMaxItemsCount.new.validate(storage)
      validation.success?
    end

    def validation_errors
      validation = Validators::CartMaxItemsCount.new.validate(storage)
      validation.failure
    end
  end
end
