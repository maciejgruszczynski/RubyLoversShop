module Products
  class SearchService < ApplicationService
    def initialize(object)
      @v = true
    end

    def call
      @v
    end
  end
end
