class CartItemsController < ApplicationController
  def create
    setup_new_cart

    product_id = cart_item_params[:product_id]
    quantity = cart_item_params[:quantity]
    result = AddProduct.new.call(cart: @current_cart, product_id: product_id, quantity: quantity)

    if result.success?
      redirect_to cart_path(@current_cart)
    else
      redirect_to product_path(product_id)
      flash[:notice] = result.failure[:message]
    end
  end

  def update
    product_id = cart_item_params[:product_id]
    quantity = cart_item_params[:quantity]
    result = UpdateProduct.new.call(cart: @current_cart, product_id: product_id, quantity: quantity)

    if result.success?
      redirect_to cart_path(@current_cart)
    else
      redirect_to product_path(product_id)
      flash[:notice] = result.failure[:message]
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])

    @cart_item.delete
    redirect_to cart_path(@current_cart)
    flash[:notice] = 'Product has been removed from cart'
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
