require 'rails_helper'

RSpec.describe Checkout::Forms::DeliveryMethod, type: :model do

  subject(:step) { described_class.new(attributes) }

  describe 'validations' do
    let(:attributes) {
      {
        'name' => 'DHL'
      }
    }

    context 'validate fields' do
      before do
        DeliveryMethod.create(name: 'DHL')
        DeliveryMethod.create(name: 'Inpost')
      end

      let(:allowed_delivery_methods) { ::DeliveryMethod.all.pluck(:name) }

      it { expect(subject).to validate_presence_of(:name) }
      it { expect(subject).to validate_inclusion_of(:name).in_array(%w(DHL Inpost)) }
      it { expect(subject.valid?).to eq true }
    end

    context 'initialize' do
      it 'should initialize form without given attributes' do
        expect(subject.is_a?(Checkout::Forms::DeliveryMethod)).to eq true
      end
    end
  end
end
