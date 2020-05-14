class ApplicationController < ActionController::Base
  before_action :set_cart



  private

  def set_cart
    @_current_cart ||= ShoppingCart.new(session)
  end

  helper_method :current_cart
  
  def current_cart
    @_current_cart
  end
end
