class CartsController < ApplicationController
  def show
    redirect_to root_path if @current_cart.new_record?
  end

  def update
    result = UpdateCart.new.call(cart: @current_cart, items: update_params[:items])

    redirect_to cart_path(@current_cart)
    if result.success?
      flash[:notice] = 'Cart updated'
    else
      flash[:notice] = result.failure[:message]
    end
  end

  def clean_cart
    CleanCart.new.call(cart: @current_cart)
    redirect_to cart_path(@current_cart)
    flash[:notice] = 'Cart has been cleaned up'
  end

  private

  def update_params
    params.permit(:id, items: {})
  end

  def setup_new_cart
    @current_cart.save
    session[:cart] = @current_cart.identifier
  end
end
