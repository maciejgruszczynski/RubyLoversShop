require 'rails_helper'

RSpec.describe Checkout do
  subject { described_class.new(step: step, session: session) }

  describe 'steps' do
    let(:session) { { 'cart' => {'1' => '2' }} }

    context 'when no step' do
      let(:session) { { 'address'=>{}, 'delivery_method'=>{}, 'payment'=>{} } }
      let(:step) { nil }

      it 'current step should be address' do
        expect(subject.current_step.name).to eq 'address'
      end

      it 'previous step should be address' do
        expect(subject.previous_step.name).to eq 'address'
      end

      it 'next step should be delivery_method' do
        expect(subject.next_step.name).to eq 'delivery_method'
      end
    end

    context 'when on address step' do
      let(:step) { 'address' }

      it 'current step should be address' do
        expect(subject.current_step.name).to eq 'address'
      end

      it 'previous step should be address' do
        expect(subject.previous_step.name).to eq 'address'
      end

      it 'next step should be delivery_method' do
        expect(subject.next_step.name).to eq 'delivery_method'
      end
    end

    context 'when on delivery_method step' do
      let(:step) { 'delivery_method' }

      it 'current step should be delivery_method' do
        expect(subject.current_step.name).to eq 'delivery_method'
      end

      it 'previous step should be address' do
        expect(subject.previous_step.name).to eq 'address'
      end

      it 'next step should be payment' do
        expect(subject.next_step.name).to eq 'payment'
      end
    end

    context 'when on payment step' do
      let(:step) { 'payment' }

      it 'current step should be payment' do
        expect(subject.current_step.name).to eq 'payment'
      end

      it 'previous step should be delivery_method' do
        expect(subject.previous_step.name).to eq 'delivery_method'
      end

      it 'next step should be summary' do
        expect(subject.next_step.name).to eq 'summary'
      end
    end

    context 'when on summary step' do
      let(:step) { 'summary' }

      it 'current step should be summary' do
        expect(subject.current_step.name).to eq 'summary'
      end

      it 'previous step should be payment' do
        expect(subject.previous_step.name).to eq 'payment'
      end

      it 'next step should be summary' do
        expect(subject.next_step.name).to eq 'summary'
      end
    end
  end

  describe 'order_summary' do
    let(:step) { 'summary' }
    let(:checkout) {
      {'address' => {
        'first_name' => 'Jan',
        'last_name' => 'Kowalski',
        'address_line' => '3-go maja 23',
        'city' => 'Wrocław',
        'postal_code' => '53-407',
        'phone_number' => '+48503633896'
      },
       'delivery_method' => {
         'name' => 'DHL'
       },
       'payment' => {}}
    }
    let(:session) { { 'checkout' => checkout, 'cart' => {'1' => '2' }} }
    let(:cart) { ShoppingCart.new({'1' => 2})}

    it 'returns Checkout::OrderSummary' do
      expect(subject.order_summary(checkout: checkout).is_a?(Checkout::OrderSummary)).to eq true
    end
  end

  describe 'perform actions' do
    context 'when no step' do
      let(:session) { { 'address'=>{}, 'delivery_method'=>{}, 'payment'=>{} } }
      let(:step) { nil }

      it 'should not perform any action' do
        expect(subject.current_step.perform_step_actions).to be true
      end
    end

    context 'when on payment step' do
      let(:step) { 'payment' }

      it 'should not perform any action' do
        expect { subject.current_step.perform_step_actions }.to_change { Order.count }.by(1)
      end
    end
  end
end
