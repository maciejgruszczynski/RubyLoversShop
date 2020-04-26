require 'rails_helper'

describe 'CreateTempCart' do
  describe "call" do

    context "create temporary cart" do
      subject(:create_temp_cart) {CreateTempCart.new.call.identifier.present?}

      it { is_expected.to eq true }
    end
  end
end
