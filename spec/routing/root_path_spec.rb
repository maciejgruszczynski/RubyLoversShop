require 'rails_helper'

RSpec.describe 'routes', type: :routing do
  it 'root_path leads to products page' do
    expect(get: '/').to route_to(controller: 'products', action: 'index')
  end
end
