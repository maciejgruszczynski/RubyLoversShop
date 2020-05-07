class ApplicationController < ActionController::Base
  before_action :set_cart

  private

  def set_cart
    @current_cart = SetCart.new.call(
      cart: @current_cart,
      current_user: current_user,
      session_cart: session[:cart]
    )
  end
end
