# frozen_string_literal: true
require 'http'
require 'cgi'

class Checkout
  module Services
    class SendToPrzelewy24
      include Dry::Monads[:result]

      def initialize
        @url = CREDENTIALS[:p24][:trn_register_url]
      end

      def call(form)
        response = HTTP.post(@url, form: form.as_json)
        error = CGI::parse(response.body.to_s)[:error]

        if error.empty?
          order = Order.find_by(identifier: form.p24_session_id)
          token = CGI::parse(response.body.to_s)['token'].first
          order.update(payment_token: token)
          order.pay!

          Success(token: token)
        end
      end
    end
  end
end
