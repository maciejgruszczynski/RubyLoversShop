module ProductHelper
  def url_method(cart:, product_id:)
    if cart.present? && cart.has_key?(product_id.to_s)
      'PATCH'
    else
      'POST'
    end
  end
end 
