class Checkout
  attr_reader :step

  def initialize(step: nil)
    @step = step
  end

  def current_step
    # find_
    # find || FIRST
    # binding.pry
    available_steps.first
  end

  def next_step
    available_steps[1]
  end

  private

  def available_steps
    [
      Steps::Address.new,
      Steps::Delivery.new
    ]
  end
end
