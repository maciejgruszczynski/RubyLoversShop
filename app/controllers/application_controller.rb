class ApplicationController < ActionController::Base
  before_action :set_cart

  private

  def set_cart
    @_current_cart ||=
    session[:cart] || {}
  end
end
