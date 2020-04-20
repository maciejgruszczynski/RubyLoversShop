class CartsController < ApplicationController

  def show
    redirect_to root_path if @cart.new_record?
  end

  def create
    cart = CreateCartService.new.call(cart_params)
    session[:cart] = cart.identifier
    redirect_to cart_path(cart)
  end

  def update
    UpdateItemsInCartService.new.call(@cart, cart_params)

    redirect_to cart_path(@cart)
  end

  private

  def cart_params
    params.permit(:id, items: {})
  end
end
