class Product < ApplicationRecord

  validates :name, presence: true
  validates :description, presence: true
  validates :code, presence: true,
                   uniqueness: true,
                   length: { is: 6 }
end
