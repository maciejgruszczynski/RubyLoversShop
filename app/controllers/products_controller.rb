class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @disabled_sidebar = true
  end

  def search
    @search_results = Products::SearchService.call(search_params)
  end

  private

  def search_params
    params.permit(:name)
  end
end
