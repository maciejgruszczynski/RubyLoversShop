class Checkout
  STEPS = %w(step1 step2 step3 step4).freeze

  attr_accessor :order_form, :current_step

  def initialize(step: nil)
    @order_form = Checkout::OrderForm::Base.new
    @current_step = step || STEPS.first
  end

  def create_order(cart:)
    Checkout::Services::CreateOrder.new.call(cart: cart)
  end

  def update(params: )
    #call other services / methods 
    self.current_step = next_step
    self
  end

  def next_step
    current_step_id = STEPS.index(current_step)
    STEPS[current_step_id + 1]
  end

  def order_form_for_step(step: )
    step = step || STEPS.first
    "Checkout::OrderForm::#{step.camelize}".constantize.new
  end
end
