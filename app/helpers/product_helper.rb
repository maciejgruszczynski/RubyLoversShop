module ProductHelper
  def url_method(product_id:)
      if current_cart.has_product?(product_id: product_id)
      'PATCH'
    else
      'POST'
    end
  end
end
