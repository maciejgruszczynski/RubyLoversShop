class Checkout
  attr_accessor :step

  def initialize(step: nil)
    @step = step
  end

  def create_order(cart:)
    Checkout::Services::CreateOrder.new.call(cart: cart)
  end

  def current_step
    available_steps.find {|step| step == } || available_steps.first
  end

  def next_step(step: current_step)
    current_step_id = available_steps.index(step)
    available_steps[current_step_id + 1].new.name
  end

  def available_steps
    [
      Checkout::Steps::Address,
      Checkout::Steps::DeliveryMethod
    ]
  end
end
