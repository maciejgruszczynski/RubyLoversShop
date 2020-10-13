module Admin
  class OrdersController < ApplicationController
    def index
      @q = Order.ransack(params[:q])
      @orders = @q.result
    end
  end
end

