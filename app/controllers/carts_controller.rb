class CartsController < ApplicationController
  def show
    redirect_to root_path if @current_cart.new_record?
  end

  def add_to_cart
    setup_new_cart if @current_cart.new_record?
    AddProduct.new.call(@current_cart, add_params)

    if @current_cart.has_no_errors?
      redirect_to cart_path(@current_cart)
    else
      redirect_to product_path(add_params[:id])
      flash[:notice] = @current_cart.all_errors
    end
  end

  def update
    UpdateCart.new.call(@current_cart, update_params)
    redirect_to cart_path(@current_cart)
    flash[:notice] = @current_cart.all_errors
  end

  def remove_from_cart
    RemoveProduct.new.call(@current_cart, params)
    redirect_to cart_path(@current_cart)
  end

  def clean_cart
    CleanCart.new.call(@current_cart)
    redirect_to cart_path(@current_cart)
    flash[:notice] = "Cart has been cleaned up"
  end

  private

  def add_params
    params.permit(:id, :quantity, :cart_id)
  end

  def update_params
    params.permit(:id, items: {})
  end

  def setup_new_cart
    @current_cart.save
    session[:cart] = @current_cart.identifier
  end
end
