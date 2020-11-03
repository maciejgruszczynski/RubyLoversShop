# frozen_string_literal: true
require 'http'
require 'cgi'

class Checkout
  module Services
    class SendToPrzelewy24
      include Dry::Monads[:result]

      def initialize
        @url = 'https://sandbox.przelewy24.pl/trnRegister'
      end

      def call(form)
        response = HTTP.post(@url, form: form.as_json)
        error = CGI::parse(response.body.to_s)[:error]

        if error.empty?
          token = CGI::parse(response.body.to_s)['token'].first
          Success(token: token)
        end
      end
    end
  end
end
