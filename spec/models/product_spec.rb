require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do
    @product = build(:product)
  end

  it "can create Product if contains valid name, description and code" do
    product = Product.new(name: "name",
                          description: "description",
                          code: '111111')

    expect(product.valid?).to eql(true)
  end

  it "Product name is mandatory" do
    @product.name = nil

    @product.validate
    expect(@product.errors[:name]).to eql(["can't be blank"])
  end

  it "Product description is mandatory" do

    @product.description = nil

    @product.validate
    expect(@product.errors[:description]).to eql(["can't be blank"])
  end

  it "Product code is mandatory and has 6 characters" do
    @product.code = nil

    @product.validate
    expect(@product.errors[:code]).to eql(["can't be blank", "is the wrong length (should be 6 characters)"])

    @product.code = "12345"

    @product.validate
    expect(@product.errors[:code]).to eql(["is the wrong length (should be 6 characters)"])

    @product.code = "1234567"

    @product.validate
    expect(@product.errors[:code]).to eql(["is the wrong length (should be 6 characters)"])
  end

  it "Product code is unique" do
    @product.save

    @product2 = Product.new(name: @product.name,
                            description: @product.description,
                            code: @product.code)
    @product2.validate
    expect(@product2.errors[:code]).to eql(["has already been taken"])
  end

end
