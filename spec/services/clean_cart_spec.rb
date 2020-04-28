require 'rails_helper'

describe 'CleanCart' do
  describe "call" do

    context "clan existing cart" do
      let(:full_cart) { create(:cart, :full_cart) }
      subject(:clean_cart) { CleanCart.new.call(full_cart).items.any? }

      it { is_expected.to eq false }
    end
  end
end
