class CartItemsController < ApplicationController
  def create
    setup_new_cart
    result = AddProduct.new.call(@current_cart, cart_item_params)

    if result.has_no_errors?
      redirect_to cart_path(@current_cart)
    else
      redirect_to product_path(add_params[:product_id])
      flash[:notice] = @current_cart.all_errors
    end
  end

  def update
    result = UpdateProduct.new.call(@current_cart, cart_item_params)

    if result.has_no_errors?
      redirect_to cart_path(@current_cart)
    else
      redirect_to product_path(cart_item_params[:product_id])
      flash[:notice] = @current_cart.all_errors
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.delete
    redirect_to cart_path(@current_cart)
    flash[:notice] = "Product has been removed from cart"

  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:cart_identifier, :product_id, :quantity)
  end

  def setup_new_cart
    @current_cart.save
    session[:cart] = @current_cart.identifier
  end
end
