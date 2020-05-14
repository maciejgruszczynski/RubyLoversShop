module ProductHelper
  def url_method(cart:, product_id:)
    if cart.items.present? && cart.items.has_key?(product_id.to_s)
      'PATCH'
    else
      'POST'
    end
  end
end
