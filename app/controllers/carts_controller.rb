class CartsController < ApplicationController
  def show
    redirect_to root_path if @current_cart.new_record?
  end

  def update
    result = UpdateCart.new.call(@current_cart, update_params)
    redirect_to cart_path(@current_cart)
    if @current_cart.has_no_errors?
      flash[:notice] = "Cart updated"
    else
      flash[:notice] = @current_cart.all_errors
    end
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
