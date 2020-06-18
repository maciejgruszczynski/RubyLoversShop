class OrdersController < ApplicationController
  # before_action :set_checkout

  def new
    @order = Order.new
    checkout = build_checkout(order: @order, step: params[:step])
    @form = checkout.current_step.form
  end

  def show
  end

  def create
    @checkout.create_order(cart: current_cart)
    redirect_to edit_orders_path(@checkout.order_form.order, step: @checkout.current_step)
  end

  def edit
    @order_form = @checkout.order_form_for_step(step: @checkout.current_step)
    # @order_form = @checkout.current_step.form
  end

  def update
    # params = send("params_#{@checkout.current_step}")
    # @checkout.update(params: params)
    # redirect_to edit_orders_path(@checkout.order_form.order, step: @checkout.current_step)
    result = checkout.update(params: params)
    if result.success?
      redirect_to checkout.current_step.success_path, notice: checkout.current_step.success_message
    else
      redirect_to checkout.current_step.failure_path, failure: checkout.current_step.failure_message
    end
  end

  private

  def build_checkout(order:, step:)
    Checkout.new(order: order, step: step)
  end

  def order_params
    params.require(:checkout_order_form_step_1).permit(:current_step)
  end

  def params_step1
    params.require(:checkout_order_form_step1).permit(:current_step, :step1)
  end
end
