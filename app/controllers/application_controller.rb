class ApplicationController < ActionController::Base
  helper_method :current_cart
  def current_cart
    @_current_cart ||= ShoppingCart.new(session)
  end
end
