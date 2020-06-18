class CheckoutController < ApplicationController
  def show
    checkout = build_checkout
    @form = checkout.current_step.form.new
    render checkout.current_step.view_template
  end

  def update
    checkout = build_checkout
    @form = checkout.current_step.form.new(checkout_params)
    if @form.valid?
      # session[:checkout] = session[:checkout].merge(@form.attributes)
      redirect_to checkout_path(step: checkout.next_step.name)
    else
      render checkout.current_step.view_template
    end
  end

  private

  def checkout_params
    params.require(:checkout).permit(:shippment_method)
  end

  def build_checkout
    # binding.pry
    Checkout.new(step: params[:step])
  end
end
