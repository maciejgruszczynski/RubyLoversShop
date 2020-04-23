class ApplicationController < ActionController::Base
  before_action :set_cart

  def set_cart(cart = nil)
    @current_cart ||= 
    if session[:cart].present?
      Cart.find_by(identifier: session[:cart])
    else
      CreateTempCart.new.call
    end
  end
end
