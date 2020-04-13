require 'rails_helper'

describe 'ProductSearchService' do
  before(:all) do
    3.times { FactoryBot.build(:shirt).save }
    3.times {FactoryBot.build(:shoes).save }
  end

  it 'looks for products' do
    search_params = {name: "Shi"}

    @search_results = Products::SearchService.call(search_params)

    expect(@search_results.count).to eq 3
    @search_results.each do |result|
      expect(result.name).to include("Shi")
    end

    search_params = {name: "shi"}

    @search_results = Products::SearchService.call(search_params)

    expect(@search_results.count).to eq 3
    @search_results.each do |result|
      expect(result.name).to include("Shi")
    end
  end

  it 'looks for products if query contains special characters' do
    search_params = {name: "%"}

    @search_results = Products::SearchService.call(search_params)

    expect(@search_results.count).to eq 0


    Product.all.first.update(name: "name")
    search_params = {name: "_"}

    @search_results = Products::SearchService.call(search_params)

    expect(@search_results.count).to eq 5
  end

  it "looks for products if name is null" do
    search_params = {name: ""}

    @search_results = Products::SearchService.call(search_params)

    expect(@search_results.count).to eq 6
  end


end
