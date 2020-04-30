class ApplicationController < ActionController::Base
  before_action :set_cart

  def set_cart(cart = nil)
    @current_cart ||=
    if user_signed_in? && current_user.has_cart?
      current_user.carts.last
    elsif user_signed_in? && current_user.has_no_cart?
      if session[:cart].present?
        CreateTempCart.new.call(user_id: current_user.id)
      else
        CreateTempCart.new.call(user_id: current_user.id)
      end
    elsif session[:cart].present?
      Cart.find_by(identifier: session[:cart])
    else
      CreateTempCart.new.call
    end
  end
end
