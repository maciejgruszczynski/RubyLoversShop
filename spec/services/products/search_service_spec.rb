require 'rails_helper'

describe 'ProductSearchService' do
  before(:all) do
    FactoryBot.create_list(:shirt, 3)
    FactoryBot.create_list(:pants, 3)
  end

  it 'looks for products - product name with lower case' do
    search_params = {q: "shi"}

    @search_results = Products::SearchService.new.call(search_params)

    expect(@search_results.count).to eq 3
    @search_results.each do |result|
      expect(result.name).to include("Shi")
    end
  end

  it 'looks for products - product name with upper case' do
    search_params = {q: "SHI"}

    @search_results = Products::SearchService.new.call(search_params)

    expect(@search_results.count).to eq 3
    @search_results.each do |result|
      expect(result.name).to include("Shi")
    end
  end

  it 'looks for products if query contains % ' do
    search_params = {q: "%"}

    @search_results = Products::SearchService.new.call(search_params)

    expect(@search_results.count).to eq 0
  end

  it 'looks for products if query contains _ ' do
    Product.all.first.update(name: "name")
    search_params = {q: "_"}

    @search_results = Products::SearchService.new.call(search_params)

    expect(@search_results.count).to eq 0
  end

  it "finds no products if name is null" do
    search_params = {q: ""}

    @search_results = Products::SearchService.new.call(search_params)

    expect(@search_results.count).to eq 0
  end

  it "finds products if 1 letter is omitted" do
    search_params = {q: "Shrt"}

    @search_results = Products::SearchService.new.call(search_params)

    expect(@search_results.count).to eq 3
  end

  it "finds products if 2 letters are omitted" do
    search_params = {q: "Shr"}

    @search_results = Products::SearchService.new.call(search_params)

    expect(@search_results.count).to eq 3
  end

  it "finds products if only 2 first letters are given" do
    search_params = {q: "pa"}

    @search_results = Products::SearchService.new.call(search_params)

    expect(@search_results.count).to eq 3
  end

  it "finds products that sounds similar" do
    search_params = {q: "shert"}

    @search_results = Products::SearchService.new.call(search_params)

    expect(@search_results.count).to eq 3
  end

end
