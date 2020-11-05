# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { build(:order) }

  describe 'state transitions' do
    context "when in state 'new'" do
      it { expect(subject).to have_state(:new).on(:state) }
      it { expect(order).to transition_from(:new).to(:with_customer_data).on_event(:fill_with_customer_data).on(:state) }
      it { expect(order).to_not transition_from(:new).to(:with_delivery_method).on_event(:fill_with_delivery_method).on(:state) }
      it { expect(order).to_not transition_from(:new).to(:with_payment_info).on_event(:fill_with_payment_info).on(:state) }
      it { expect(order).to_not transition_from(:new).to(:waiting_for_payment).on_event(:pay).on(:state) }
      it { expect(order).to_not transition_from(:new).to(:paid).on_event(:confirm_payment).on(:state) }
      it { expect(order).to_not transition_from(:new).to(:with_payment_errors).on_event(:add_payment_errors).on(:state) }
    end

    context "when in state 'with_customer_data'" do
      before do
        order.state = 'with_customer_data'
      end

      it { expect(order).to have_state(:with_customer_data).on(:state) }
      it { expect(order).to transition_from(:with_customer_data).to(:with_delivery_method).on_event(:fill_with_delivery_method).on(:state) }
      it { expect(order).to_not transition_from(:with_customer_data).to(:with_payment_info).on_event(:fill_with_payment_info).on(:state) }
      it { expect(order).to_not transition_from(:with_customer_data).to(:waiting_for_payment).on_event(:pay).on(:state) }
      it { expect(order).to_not transition_from(:with_customer_data).to(:paid).on_event(:confirm_payment).on(:state) }
      it { expect(order).to_not transition_from(:with_customer_data).to(:with_payment_errors).on_event(:add_payment_errors).on(:state) }
    end

    context "when in state 'with_delivery_method'" do
      before do
        order.state = 'with_delivery_method'
      end

      it { expect(order).to have_state(:with_delivery_method).on(:state) }
      it { expect(order).to transition_from(:with_delivery_method).to(:with_payment_info).on_event(:fill_with_payment_info).on(:state) }
      it { expect(order).to_not transition_from(:with_delivery_method).to(:waiting_for_payment).on_event(:pay).on(:state) }
      it { expect(order).to_not transition_from(:with_delivery_method).to(:paid).on_event(:confirm_payment).on(:state) }
      it { expect(order).to_not transition_from(:with_delivery_method).to(:with_payment_errors).on_event(:add_payment_errors).on(:state) }
    end

    context "when in state 'with_payment_info'" do
      before do
        order.state = 'with_payment_info'
      end

      it { expect(order).to have_state(:with_payment_info).on(:state) }
      it { expect(order).to transition_from(:with_payment_info).to(:waiting_for_payment).on_event(:pay).on(:state) }
      it { expect(order).to_not transition_from(:with_delivery_method).to(:paid).on_event(:confirm_payment).on(:state) }
      it { expect(order).to_not transition_from(:with_delivery_method).to(:with_payment_errors).on_event(:add_payment_errors).on(:state) }
    end

    context "when in state 'waiting_for_payment'" do
      before do
        order.state = 'waiting_for_payment'
      end

      it { expect(order).to have_state(:waiting_for_payment).on(:state) }
      it { expect(order).to transition_from(:waiting_for_payment).to(:paid).on_event(:confirm_payment).on(:state) }
      it { expect(order).to transition_from(:waiting_for_payment).to(:with_payment_errors).on_event(:add_payment_errors).on(:state) }
    end
  end
end
