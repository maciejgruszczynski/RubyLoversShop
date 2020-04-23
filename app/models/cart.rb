class Cart < ApplicationRecord
  MAX_ITEM_OCCURENCES = 5
  MAX_ITEMS = 10

  has_many :items, class_name: 'CartItem'

  accepts_nested_attributes_for :items

  validates :identifier, presence: true,
                         uniqueness: true,
                         length: { is: 8 }

  def has_no_errors?
    errors.empty? && items.select {|i| i.errors.any? }.empty?
  end

  def all_errors
    Array.new << errors.full_messages << items.map {|i| i.errors.full_messages if i.errors}
  end

  validates_associated :cart_item

  #def validate_items_count
  #  if items.map { |e| e.quantity }.sum > 10
  #    errors[:base] << 'max 10 items allowed'
  #  end
  #end
end
