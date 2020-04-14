module Products
  class SearchService < ApplicationService
    def initialize(search_params)
      @name = search_params[:q]
    end

    def call
      Product.where("products.name ILIKE ?", "%#{sanitize_sql(@name)}%")
    end

    private

    def sanitize_sql(str)
      str.gsub(/[_%]/) { |c| "\\#{c}" }
    end
  end
end
