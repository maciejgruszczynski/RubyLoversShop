class CartsController < ApplicationController
  def show
    redirect_to root_path if @current_cart.new_record?
  end

  def add_to_cart
    cart_param = add_params[:cart_id]
    cart = cart_param.empty? ? CreateCart.new.call : Cart.find(cart_param)
    session[:cart] = cart.identifier
    cart = AddProduct.new.call(cart, add_params)
    if cart.items.select {|i| i.errors.any? }.empty?
      redirect_to cart_path(cart)
    else
      errors = []
      cart.items.each {|i| errors << i.errors.full_messages if i.errors.any? }
      redirect_to product_path(add_params[:id])
      flash[:notice] = errors
    end
  end

  def update
    UpdateCart.new.call(@current_cart, update_params)

    redirect_to cart_path(@current_cart)
  end

  private

  def add_params
    params.permit(:id, :quantity, :cart_id)
  end

  def update_params
    params.permit(:id, items: {})
  end
end
