module Products
  class SearchService
    def call(search_params)
      name = search_params[:q]
      Product.where("products.name ILIKE ?", "%#{sanitize_sql(name)}%")
    end

    private

    def sanitize_sql(str)
      str.gsub(/[_%]/) { |c| "\\#{c}" }
    end
  end
end
