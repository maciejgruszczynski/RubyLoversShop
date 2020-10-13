class CheckoutController < ApplicationController
  def show
    @checkout = build_checkout
    checkout_session

    if @checkout.not_last_step?
      @form = @checkout.current_step.form.new(session[:checkout][@checkout.current_step.name])
    else
      @order_summary = @checkout.order_summary(checkout: checkout_session)
    end

    render @checkout.current_step.view_template
  end

  def update
    checkout = build_checkout
    @form = @checkout.current_step.form.new(checkout_params)

    if @form.valid?
      session[:checkout] = checkout_session.merge({ checkout.current_step.name => checkout_params })
      redirect_to checkout_path(step: checkout.next_step.name)
    else
      render @checkout.current_step.view_template
    end
  end

  private

  def build_checkout
    @checkout ||=  Checkout.new(step: params[:step], session: session)
  end

  def checkout_session
    if session[:checkout].presence
      session[:checkout]
    else
      session[:checkout] = @checkout.empty_session
    end
  end

  def checkout_params
    params.require(:checkout).permit!
  end

  def reset_cart
    session[:cart] = {}
  end
end
