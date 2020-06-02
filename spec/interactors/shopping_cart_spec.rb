require 'rails_helper'

RSpec.describe ShoppingCart do
  let(:session) { {} }
  let(:shopping_cart) { described_class.new(session) }

  subject { described_class.new(session) }

  describe '#add_item' do
    let(:product) { create(:product) }
    let(:add_item_service) { instance_double(ShoppingCart::Services::AddItem) }

    before { allow(ShoppingCart::Services::AddItem).to receive(:new).and_return(add_item_service) }

    it 'calls ShoppingCart:Services::AddItem' do
      expect(add_item_service).to receive(:call).with(
        store: subject.store,
        product_id: product.id,
        quantity: 1
      )

      subject.add_item(product_id: product.id, quantity: 1)
    end
  end

  describe '#update_item' do
    let(:update_item_service) { instance_double(ShoppingCart::Services::UpdateItem) }

    before { allow(ShoppingCart::Services::UpdateItem).to receive(:new).and_return(update_item_service) }

    it 'calls ShoppingCart:Services::UpdateItem' do
      expect(update_item_service).to receive(:call).with(
        store: subject.store,
        product_id: 1,
        quantity: 1
      )

      subject.update_item(product_id: 1, quantity: 1)
    end
  end

  describe '#update_cart' do
    let(:update_cart_service) { instance_double(ShoppingCart::Services::UpdateCart) }
    let(:update_params) {
      {
        '1' => { 'quantity' => '5' },
        '2' => { 'quantity' => '5' }
      }
    }

    before { allow(ShoppingCart::Services::UpdateCart).to receive(:new).and_return(update_cart_service) }

    it 'calls ShoppingCart:Services::UpdateCart' do
      expect(update_cart_service).to receive(:call).with(
        store: subject.store,
        items_after_update: update_params
      )

      subject.update_cart(items_after_update: update_params)
    end
  end

  describe '#destroy_cart' do
    let(:destroy_cart_service) { instance_double(ShoppingCart::Services::DestroyCart) }

    before { allow(ShoppingCart::Services::DestroyCart).to receive(:new).and_return(destroy_cart_service) }

    it 'calls ShoppingCart:Services::DestroyCart' do
      expect(destroy_cart_service).to receive(:call)

      subject.destroy_cart
    end
  end

  describe '#remove_item' do
    let(:remove_item_service) { instance_double(ShoppingCart::Services::RemoveItem) }

    before { allow(ShoppingCart::Services::RemoveItem).to receive(:new).and_return(remove_item_service) }

    it 'calls ShoppingCart:Services::RemoveItem' do
      expect(remove_item_service).to receive(:call).with(
        store: subject.store,
        product_id: 1
      )

      subject.remove_item(product_id: 1)
    end
  end

  describe '#items' do
    let(:items) { { '1' => 2, '2' => 2 } }
    before { allow(subject.store).to receive(:content).and_return(items) }

    it 'returns CartItems' do
      expect(subject.items.map(&:class).first).to eq(ShoppingCart::Entities::CartItem)
    end
  end

  describe '#has_product?' do
    let(:items) { { '1' => 2, '2' => 2 } }
    before { allow(subject.store).to receive(:content).and_return(items) }

    it 'returns true' do
      expect(subject.has_product?(product_id: '1')).to eq true
    end
  end
end
