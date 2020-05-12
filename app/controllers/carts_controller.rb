class CartsController < ApplicationController
  def show
  end

  def update
    result = UpdateCart.new.call(cart: @current_cart, items_after_update: update_params[:items])

    redirect_to cart_path(@current_cart)
    if result.success?
      flash[:notice] = 'Cart updated'
    else
      flash[:notice] = result.failure[:message]
    end
  end

  def destroy
    CleanCart.new.call(cart: @current_cart)
    redirect_to cart_path(@current_cart)
    flash[:notice] = 'Cart has been cleaned up'
  end

  private

  def update_params
    params.permit(:id, items: {})
  end
end
