class CheckoutController < ApplicationController

  def show
    #binding.pry
    checkout = build_checkout
    @form = checkout.current_step.new.form.new
    @next_step = checkout.next_step

    render checkout.current_step.new.view_template
  end

  def update
    #binding.pry
    #checkout = build_checkout

    redirect_to checkout_path(step: params[:step])
  end

  private

  def build_checkout
    @checkout ||=  Checkout.new(step: params[:step])
  end

  def checkout_params
    params.require(:checkout).permit()
  end
end
