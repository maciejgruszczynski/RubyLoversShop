class RemoveProduct
  def call(cart, params)
    item = CartItem.find(params[:id]).destroy
  end
end
