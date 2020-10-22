module Admin
  class OrdersController < BaseController
    def index
      @q = Order.ransack(params[:q])
      @orders = @q.result
    end
  end
end

