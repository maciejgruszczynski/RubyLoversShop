class Checkout
  attr_reader :step, :cart, :identifier, :order

  def initialize(step: nil, session:)
    @step = step
    @cart = ::ShoppingCart::new(session)
    @identifier =  session.dig('checkout', 'identifier') || order_identifier
    @order = build_order
  end

  def current_step
    available_steps[step] || available_steps.first[1]
  end

  def next_step
    next_step_name = step_names[current_step_id + 1]
    available_steps[next_step_name] || current_step
  end

  def previous_step
    if first_step?
      current_step
    else
      previous_step_name = step_names[current_step_id - 1]
      available_steps[previous_step_name]
    end
  end

  def available_steps
    {
      'address' => Checkout::Steps::Address.new(self),
      'delivery_method' => Checkout::Steps::DeliveryMethod.new(self),
      'payment_info' => Checkout::Steps::PaymentInfo.new(self),
      'payment' => Checkout::Steps::Payment.new(self),
      'summary' => Checkout::Steps::OrderSummary.new
    }
  end

  def not_last_step?
    step != step_names.last
  end

  def first_step?
    step == step_names.first || step.nil? || cart == {}
  end

  def order_summary(checkout:)
    if last_step?
      Checkout::OrderSummary.new(checkout: checkout, cart: cart)
    end
  end

  def empty_session
    { 'address'=>{}, 'delivery_method'=>{}, 'payment_info'=>{} }
  end

  private

  def step_names
    available_steps.keys
  end

  def current_step_id
    available_steps.keys.index(current_step.name)
  end

  def last_step?
    step == step_names.last
  end

  def build_order
    Order.where(
      identifier: identifier, final_price_net_cents: cart.value.cents, final_price_net_currency: cart.value.currency.iso_code
    ).first_or_create
  end

  def order_identifier
    SecureRandom.base64(10).tr('+/=lIO0', 'abcdefg')
  end
end
