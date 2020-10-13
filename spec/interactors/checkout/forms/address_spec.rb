require 'rails_helper'

RSpec.describe Checkout::Forms::Address, type: :model do

  subject(:step) { described_class.new(attributes) }

  describe 'validations' do
    let(:attributes) {
      {
        'first_name' => 'Jan',
        'last_name' => 'Kowalski',
        'address_line' => '3-go maja 23',
        'city' => 'Wrocław',
        'postal_code' => '53-407',
        'phone_number' => '+48503633896'
      }
    }

    context 'validate fields' do
      it { expect(subject).to validate_presence_of(:first_name) }
      it { expect(subject).to validate_presence_of(:last_name) }
      it { expect(subject).to validate_presence_of(:address_line) }
      it { expect(subject).to validate_presence_of(:city) }
      it { expect(subject).to validate_presence_of(:postal_code) }
      it { expect(subject).to validate_presence_of(:phone_number) }
      it { expect(subject.valid?).to eq true }
    end

    context 'initialize' do
      it 'should initialize form without given attributes' do
        expect(subject.is_a?(Checkout::Forms::Address)).to eq true
      end
    end
  end
end
