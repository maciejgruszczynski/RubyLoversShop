class CartsController < ApplicationController
  helper_method :current_cart

  def show
  end

  def update
    result = ShoppingCart.new(session).update_cart(items_after_update: update_params[:items])

    redirect_to carts_path
    if result.success?
      flash[:notice] = 'Cart updated'
    else
      flash[:notice] = result.failure[:message]
    end
  end

  def destroy
    result = current_cart.destroy
    redirect_to carts_path
    flash[:notice] = 'Cart has been cleaned up'
  end

  private

  def update_params
    params.permit(items: {})
  end
end
