# frozen_string_literal: true
require 'http'
require 'cgi'

class Checkout
  module Services
    class ConfirmPayment

      def initialize
        @url = ENV['P24_TRN_VERIFY_URL']
      end

      def call(params)
        order = Order.find_by(identifier: params[:p24_session_id])
        payload = {
          "p24_pos_id"=>params[:p24_pos_id],
          "p24_merchant_id"=>params[:p24_merchant_id],
          "p24_session_id"=>params[:p24_session_id],
          "p24_amount"=>params[:p24_amount],
          "p24_currency"=>params[:p24_currency],
          "p24_order_id"=>params[:p24_order_id],
          "p24_sign"=>params[:p24_sign]
        }.as_json

        response = HTTP.post(@url, form: payload)

        errors = CGI::parse(response.body.to_s)[:error]

        if errors.empty?
          order.confirm_payment!
        else
          order.update(payment_errors: errors)
          order.add_payment_errors!
        end
      end
    end
  end
end
