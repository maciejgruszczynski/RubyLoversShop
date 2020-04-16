module Products
  class SearchService
    def call(search_params)
      name = search_params[:q]
      Product.search_by_name(name)
    end
  end
end
