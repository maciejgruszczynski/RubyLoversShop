class ProductsController < ApplicationController
  def index
    @products = Product.paginate(page: params[:page])
  end

  def show
    @disabled_sidebar = true
    @product = Product.find(params[:id])
  end

  def search
    @products = Product.search_by_name(search_params[:q]).paginate(page: params[:page])
  end

  def add_to_cart
    cart = AddToCartService.new.call(@cart, add_to_cart_params)
    set_cart(cart) if @cart.new_record?
    cart.validate_items_count
    if cart.errors.any?
      redirect_to product_path(params[:id])
      flash[:notice] = cart.errors.full_messages
    else
      redirect_to cart_path(@cart)
    end

    puts @cart.errors
  end

  private

  def search_params
    params.permit(:q)
  end

  def add_to_cart_params
    params.permit(:id, :quantity)
  end
end
