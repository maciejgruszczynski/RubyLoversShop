class ProductsController < ApplicationController
  def index
    @products = Product.paginate(page: params[:page])
  end

  def show
    @disabled_sidebar = true
    @product = Product.find(params[:id])
    @cart_item = @current_cart.items.where(product_id: params[:id]).first_or_initialize
  end

  def search
    @products = Product.search_by_name(search_params[:q]).paginate(page: params[:page])
  end

  private

  def search_params
    params.permit(:q)
  end
end
