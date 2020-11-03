class Checkout
  module Api
    module V1
      class P24Controller < ApiController
        #post
        def url_status
          order = Order.find_by(order_identifier: params[:p24_order_id])
        end

        private

        def p24_params
          params.permit!
        end
      end
    end
  end
end
