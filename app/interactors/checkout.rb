class Checkout
  attr_accessor :step

  def initialize(step: nil)
    @step = step
  end

  def current_step
    current_step = available_steps[step] || available_steps.first[1]
  end

  def next_step
    next_step_name = step_names[current_step_id + 1]
    available_steps[next_step_name] || current_step
  end

  def previous_step
    previous_step_name = step_names[current_step_id - 1]
    available_steps[previous_step_name] || current_step
  end

  def available_steps
    {
      'address' => Checkout::Steps::Address.new,
      'delivery_method' => Checkout::Steps::DeliveryMethod.new
    }
  end

  private

  def step_names
    available_steps.keys
  end

  def current_step_id
    available_steps.keys.index(current_step.name)
  end
end
