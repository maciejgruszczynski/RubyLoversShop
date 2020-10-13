require 'rails_helper'

RSpec.describe Checkout::Forms::Payment, type: :model do

  subject(:step) { described_class.new(attributes) }

  describe 'validations' do
    let(:attributes) { nil }

    context 'validate fields' do
      it { expect(subject.valid?).to eq true }
    end

    context 'initialize' do
      it 'should initialize form without given attributes' do
        expect(subject.is_a?(Checkout::Forms::Payment)).to eq true
      end
    end
  end
end
