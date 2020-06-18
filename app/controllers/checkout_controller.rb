class CheckoutController < ApplicationController
  def show
    @checkout = build_checkout
    @form = @checkout.current_step.form.new

    render @checkout.current_step.view_template
  end

  def update
    checkout = build_checkout
    redirect_to checkout_path(step: checkout.next_step.name)
  end

  private

  def build_checkout
    @checkout ||=  Checkout.new(step: params[:step])
  end

  def checkout_params
    params.require(:checkout).permit()
  end
end
