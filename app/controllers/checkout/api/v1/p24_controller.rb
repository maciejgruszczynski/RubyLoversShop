class Checkout
  module Api
    module V1
      class P24Controller < ApiController
        #post
        def url_status
          Checkout::Services::ConfirmPayment.new.call(params)
        end

        private

        def p24_params
          params.permit!
        end
      end
    end
  end
end
