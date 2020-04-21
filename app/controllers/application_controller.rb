class ApplicationController < ActionController::Base
  before_action :set_cart

  def set_cart
    @current_cart = session[:cart].present? ? Cart.find_by(identifier: session[:cart]) : Cart.new
  end
end
