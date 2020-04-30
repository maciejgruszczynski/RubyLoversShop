class Cart < ApplicationRecord
  MAX_ITEM_OCCURENCES = 5
  MAX_ITEMS = 10

  has_many :items, class_name: 'CartItem'
  belongs_to :user

  accepts_nested_attributes_for :items

  validates :identifier, presence: true,
                         uniqueness: true,
                         length: { is: 8 }
end
