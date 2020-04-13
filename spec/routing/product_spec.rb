require 'rails_helper'

RSpec.describe "routes", type: :routing do
  it "routes to list of all products" do
    expect(get: "/products").to route_to(controller: "products", action: "index")
  end

  it "routes to product show page" do
    expect(get: "/products/1").to route_to(controller: "products", action: "show", id: "1")
  end
end
