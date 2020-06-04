class OrdersController < ApplicationController
  before_action :set_checkout

  def show
  end

  def create
    @checkout.create_order(cart: current_cart)
    redirect_to edit_orders_path(@checkout.order_form.order, step: @checkout.current_step)
  end

  def edit
    @order_form = @checkout.order_form_for_step(step: @checkout.current_step)
  end

  def update
    params = send("params_#{@checkout.current_step}")
    @checkout.update(params: params)
    redirect_to edit_orders_path(@checkout.order_form.order, step: @checkout.current_step)
  end

  private

  def set_checkout
    @checkout ||=  Checkout.new(step: params[:step])
  end

  def order_params
    params.require(:checkout_order_form_step_1).permit(:current_step)
  end

  def params_step1
    params.require(:checkout_order_form_step1).permit(:current_step, :step1)
  end
end
