require 'rails_helper'

describe Cart, type: :model do
  let(:cart) {create(:cart)}
  let(:cart_item) {create(:cart_item)}

  it "test" do
    binding.pry
  end
end
