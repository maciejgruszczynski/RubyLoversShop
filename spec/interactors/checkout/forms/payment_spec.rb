require 'rails_helper'

RSpec.describe Checkout::Forms::Payment, type: :model do

  subject(:form) { described_class.new(attributes) }

  describe 'validations' do
    let(:attributes) {
      {
        'p24_merchant_id' => 111,
        'p24_pos_id' => 1101,
        'p24_session_id' => 'p24_session_id',
        'p24_amount' => 1000,
        'p24_currency' => 'PLN',
        'p24_description' => 'description',
        'p24_email' => 'p24_email',
        'p24_client' => 'Jan Kowalski',
        'p24_address' => 'Tęczowa 18',
        'p24_zip' => '40-881',
        'p24_city' => 'Katowice',
        'p24_country' => 'PL',
        'p24_phone' => '481321132123',
        'p24_language' => 'pl',
        'p24_url_return' => 'http://url.return',
        'p24_url_status' => 'http://url.status',
        'p24_time_limit' => 0,
        'p24_wait_for_result' => 0,
        'p24_channel' => 2,
        'p24_shipping' => 0,
        'p24_transfer_label' => 'opis_przelewu',
        'p24_api_version' => '3.2',
        'p24_sign' => '6c7f0bb62c046fbc89921dc3b2b23ede',
        'p24_encoding' => 'UTF-8'
      }
    }

    context 'validate mandatory fields' do
      context 'p24_merchant_id' do
        it { expect(form).to validate_presence_of(:p24_merchant_id) }
        it { expect(form).to validate_numericality_of(:p24_merchant_id) }
      end

      context 'p24_pos_id' do
        it { expect(form).to validate_presence_of(:p24_pos_id) }
        it { expect(form).to validate_numericality_of(:p24_pos_id) }
      end

      context 'p24_session_id' do
        it { expect(form).to validate_length_of(:p24_session_id).is_at_most(100) }
        it { expect(form).to validate_presence_of(:p24_session_id) }
      end

      context 'p24_amount' do
        it { expect(form).to validate_presence_of(:p24_amount) }
        it { expect(form).to validate_numericality_of(:p24_amount) }
      end

      context 'p24_currency' do
        it { expect(form).to validate_presence_of(:p24_currency) }
        it { expect(form).to validate_length_of(:p24_currency).is_equal_to(3) }
        it { expect(form).to validate_inclusion_of(:p24_currency).in_array(%w(PLN, EUR, GBP, CZK)) }
      end

      context 'p24_description' do
        it { expect(form).to validate_presence_of(:p24_description) }
        it { expect(form).to validate_length_of(:p24_description).is_at_most(1024) }
      end

      context 'p24_email' do
        it { expect(form).to validate_presence_of(:p24_email) }
        it { expect(form).to validate_length_of(:p24_email).is_at_most(50) }
      end

      context 'p24_country' do
        let(:allowed_country_codes) { %w(AD AT BE CY CZ DK EE FI FR EL ES NL IE IS LT LV LU MT NO PL
                                         PT SM SK SI CH SE HU GB IT US CA JP UA BY RU) }

        it { expect(form).to validate_presence_of(:p24_country) }
        it { expect(form).to validate_length_of(:p24_country).is_equal_to(2) }
        it { expect(form).to validate_inclusion_of(:p24_country).in_array(allowed_country_codes) }

      end

      context 'p24_url_return' do
        it { expect(form).to validate_presence_of(:p24_url_return) }
        it { expect(form).to validate_length_of(:p24_url_return).is_at_most(250) }
      end

      context 'p24_api_version' do
        it { expect(form).to validate_presence_of(:p24_api_version) }
        it { expect(form).to validate_length_of(:p24_api_version).is_at_most(5) }
        it { expect(form).to validate_inclusion_of(:p24_api_version).in_array(%w( 3.2 )) }
      end

      context 'p24_client' do
        it { expect(form).to_not validate_presence_of(:p24_client) }
      end

      context 'p24_address' do
        it { expect(form).to_not validate_presence_of(:p24_address) }
      end

      context 'p24_zip' do
        it { expect(form).to_not validate_presence_of(:p24_zip) }
      end

      context 'p24_city' do
        it { expect(form).to_not validate_presence_of(:p24_city) }
      end
    end

    context 'with credit cards payments (p24_channel == 1)' do
      before do
        attributes['p24_channel'] = 1
      end

      context 'p24_client' do
        it { expect(form).to validate_presence_of(:p24_client) }
      end

      context 'p24_address' do
        it { expect(form).to validate_presence_of(:p24_address) }
      end

      context 'p24_zip' do
        it { expect(form).to validate_presence_of(:p24_zip) }
      end

      context 'p24_city' do
        it { expect(form).to validate_presence_of(:p24_city) }
      end
    end

    context 'with all payments (p24_channel == 16)' do
      before do
        attributes['p24_channel'] = 16
      end

      context 'p24_client' do
        it { expect(form).to validate_presence_of(:p24_client) }
      end

      context 'p24_address' do
        it { expect(form).to validate_presence_of(:p24_address) }
      end

      context 'p24_zip' do
        it { expect(form).to validate_presence_of(:p24_zip) }
      end

      context 'p24_city' do
        it { expect(form).to validate_presence_of(:p24_city) }
      end
    end

    context 'validate optional fields' do
      context 'p24_client' do
        it { expect(form).to validate_length_of(:p24_client).is_at_most(50) }
      end

      context 'p24_address' do
        it { expect(form).to validate_length_of(:p24_address).is_at_most(80) }
      end

      context 'p24_zip' do
        it { expect(form).to validate_length_of(:p24_zip).is_at_most(10) }
      end

      context 'p24_city' do
        it { expect(form).to validate_length_of(:p24_city).is_at_most(50) }
      end

      context 'p24_phone' do
        it { expect(form).to validate_length_of(:p24_phone).is_at_most(12) }
      end

      context 'p24_language' do
        it { expect(form).to validate_length_of(:p24_language).is_equal_to(2) }
        it { expect(form).to validate_inclusion_of(:p24_language).in_array(%w( pl en de es it )) }
      end

      context 'p24_url_status' do
        it { expect(form).to validate_length_of(:p24_url_status).is_at_most(250) }
      end

      context 'p24_time_limit' do
        it { expect(form).to validate_numericality_of(:p24_time_limit).only_integer.is_less_than_or_equal_to(99) }
      end

      context 'p24_wait_for_result' do
        it { expect(form).to validate_numericality_of(:p24_wait_for_result).only_integer.is_less_than_or_equal_to(1) }
      end

      context 'p24_channel' do
        it { expect(form).to validate_numericality_of(:p24_channel).only_integer }
        it { expect(form).to validate_inclusion_of(:p24_channel).in_array([1,2,4,16,32]) }
      end

      context 'p24_shipping' do
        it { expect(form).to validate_numericality_of(:p24_shipping).only_integer }
      end

      context 'p24_transfer_label' do
        it { expect(form).to validate_length_of(:p24_transfer_label).is_at_most(20) }
      end

      context 'p24_encoding' do
        it { expect(form).to validate_length_of(:p24_encoding).is_at_most(15) }
        it { expect(form).to validate_inclusion_of(:p24_encoding).in_array(%w( ISO-8859-2 UTF-8 Windows-1250 )) }
      end
    end
  end

  describe 'initialization' do
    context 'without attributes' do
      let(:attributes) { nil }

      it 'should not initialize form without given attributes' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end
end




