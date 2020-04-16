class Product < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_name, against: :name, using: {
    trigram: {
      threshold: 0.2
    },
    tsearch: {
        any_word: true,
        prefix: true
    },
    dmetaphone: {}
  }

  validates :name, presence: true
  validates :description, presence: true
  validates :code, presence: true, uniqueness: {case_sensitive: false}, length: { is: 6 }
  monetize :price_cents, numericality: { greater_than: 0 }

  self.per_page = 10

  def price
    Money.new(self.price_cents, self.price_currency)
  end
end
