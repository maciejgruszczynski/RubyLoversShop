class CartItemsController < ApplicationController
  def create
    product_id = cart_item_params[:product_id]
    quantity = cart_item_params[:quantity]

    result = current_cart.add_item(
      product_id: product_id,
      quantity: quantity
    )

    if result.success?
      redirect_to carts_path
    else
      redirect_to product_path(product_id)
      flash[:notice] = result.failure[:message]
    end

  end

  def update
    product_id = cart_item_params[:product_id]
    quantity = cart_item_params[:quantity]

    result = current_cart.update_item(
      product_id: product_id,
      quantity: quantity
    )

    if result.success?
      redirect_to carts_path
    else
      redirect_to product_path(product_id)
      flash[:notice] = result.failure[:message]
    end
  end

  def destroy
    current_cart.remove_item(product_id: cart_item_params[:product_id])
    redirect_to carts_path
    flash[:notice] = 'Product has been removed from cart'
  end

  private

  def cart_item_params
    params.permit(:product_id, :quantity)
  end
end
