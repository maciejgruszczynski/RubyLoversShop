class ProductsController < ApplicationController
  def index
    @products = Product.paginate(page: params[:page])
  end

  def show
    @product = Product.find(params[:id])
    @disabled_sidebar = true
  end

  def search
    @products = Products::SearchService.new.call(search_params).paginate(page: params[:page])
  end

  private

  def search_params
    params.permit(:q)
  end
end
