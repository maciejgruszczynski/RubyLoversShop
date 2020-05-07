class SetCart
  def call(cart:, current_user:, session_cart:)

    if current_user.present?
      if current_user.carts.any?
        cart = current_user.carts.last
        cart.update(user_id: current_user.id)
      else
        CreateTempCart.new.call(user_id: current_user.id)
      end
    elsif session_cart.present?
        Cart.find_by(identifier: session_cart)
    elsif current_user.present?
      Cart.find_by(cart_id: current_user.id)
    else
      CreateTempCart.new.call(user_id: nil)
    end
  end
end
