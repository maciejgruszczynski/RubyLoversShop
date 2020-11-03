class Checkout
  module Forms
    class Payment < Base
      attr_accessor :p24_merchant_id, :p24_pos_id, :p24_session_id, :p24_amount, :p24_currency, :p24_description, :p24_email,
                    :p24_client, :p24_address, :p24_zip, :p24_city, :p24_country, :p24_phone, :p24_language, :p24_url_return,
                    :p24_url_status, :p24_time_limit, :p24_wait_for_result, :p24_channel, :p24_shipping, :p24_transfer_label,
                    :p24_api_version, :p24_sign, :p24_encoding

      ALLOWED_CURRENCIES = %w( PLN, EUR, GBP, CZK )
      ALLOWED_COUNTRY_CODES = %w( AD AT BE CY CZ DK EE FI FR EL ES NL IE IS LT LV LU MT NO PL
                                 PT SM SK SI CH SE HU GB IT US CA JP UA BY RU )
      ALLOWED_API_VERSIONS = %w( 3.2 )
      ALLOWED_LANGUAGES = %w( pl en de es it )
      ALLOWED_CHANNELS = [1,2,4,16,32]
      ALLOWED_ENCODINGS = %w( ISO-8859-2 UTF-8 Windows-1250 )

      validates :p24_merchant_id, presence: true, numericality: { only_integer: true }
      validates :p24_pos_id, presence: true, numericality: { only_integer: true }
      validates :p24_session_id, presence: true, length: { maximum: 100 }
      validates :p24_amount, presence: true, numericality: { only_integer: true }
      validates :p24_currency, presence: true, length: { is: 3 }, inclusion: { in: ALLOWED_CURRENCIES }
      validates :p24_description, presence: true, length: { maximum: 1024 }
      validates :p24_email, presence: true, length: { maximum: 50 }
      validates :p24_country, presence: true, length: { is: 2 }, inclusion: { in: ALLOWED_COUNTRY_CODES }
      validates :p24_url_return, presence: true, length: { maximum: 250 }
      validates :p24_api_version, presence: true, length: { maximum: 5 }, inclusion: { in: ALLOWED_API_VERSIONS }
      validates :p24_client, presence: true, if: :payment_with_credit_cart?
      validates :p24_address, presence: true, if: :payment_with_credit_cart?
      validates :p24_zip, presence: true, if: :payment_with_credit_cart?
      validates :p24_city, presence: true, if: :payment_with_credit_cart?
      validates :p24_client, length: { maximum: 50 }
      validates :p24_address, length: { maximum: 80 }
      validates :p24_zip, length: { maximum: 10 }
      validates :p24_city, length: { maximum: 50 }
      validates :p24_phone, length: { maximum: 12 }
      validates :p24_language, length: { is: 2 }, inclusion: { in: ALLOWED_LANGUAGES }
      validates :p24_url_status, length: { maximum: 250 }
      validates :p24_time_limit, numericality: { only_integer: true, less_than_or_equal_to: 99 }
      validates :p24_wait_for_result, numericality: { only_integer: true, less_than_or_equal_to: 1 }
      validates :p24_channel, numericality: { only_integer: true }, inclusion: { in: ALLOWED_CHANNELS }
      validates :p24_shipping, numericality: { only_integer: true }
      validates :p24_transfer_label, length: { maximum: 20 }
      validates :p24_encoding, length: { maximum: 15 }, inclusion: { in: ALLOWED_ENCODINGS }


      def initialize(attributes = {})
        verify_presence_of_attributes(attributes)

        #attributes.each do |attr, val|
        #  raise ArgumentError unless PERMITTED_ATTRIBUTES.include?(attr)

        #  define_singleton_method("#{attr}=") { |val| attributes[attr] = val }
        # define_singleton_method(attr) { attributes[attr] }
        #end
        @p24_merchant_id = ENV['P24_MERCHANT_ID']
        @p24_pos_id = ENV['P24_POS_ID']
        @p24_session_id = order_identifier
        @p24_url_return = 'http://c4fa2aad7dbe.ngrok.io/checkout/summary'
        @p24_url_status = 'http://c4fa2aad7dbe.ngrok.io/checkout/api/v1/p24/url_status'
        @p24_api_version = ENV['P24_API_VERSION']
        @p24_amount = 720
        @p24_currency = 'PLN'
        @p24_description = order_description
        @p24_sign = generate_p24_sign
        @p24_email = 'a@a.pl'
      end

      #according to p24 spec - 1 => credit card 16 => all payment methods
      def payment_with_credit_cart?
        p24_channel.in?([1,16])
      end

      def order_identifier
        SecureRandom.base64(10).tr('+/=lIO0', 'abcdefg')
      end

      def order_description
        "Zamówienie nr #{p24_session_id}"
      end

      def generate_p24_sign
        #str = "#{p24_session_id.to_s}|#{p24_merchant_id.to_s}|#{p24_amount.to_s}|#{p24_currency.to_s}|#{ENV['P24_CRC_KEY'].to_s}"
        checksum = [
          p24_session_id,
          p24_merchant_id,
          p24_amount,
          p24_currency,
          '16cbaf7e158a7a7b'
        ].join('|')

        Digest::MD5.hexdigest(checksum)
      end
    end
  end
end
