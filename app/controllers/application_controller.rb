class ApplicationController < ActionController::Base
  before_action :set_cart

  def set_cart(cart = nil)
    if cart.nil?
      @cart = session[:cart].present? ? Cart.find_by(identifier: session[:cart]) : Cart.new
    else
      session[:cart] = cart.identifier
      @cart = cart
    end
  end
end
