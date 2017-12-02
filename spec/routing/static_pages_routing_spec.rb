require 'rails_helper'

describe 'Static pages routing' do
  describe 'root' do
    it 'routes to home' do
      expect(get: root_path).to route_to(controller: 'static_pages', action: 'home')
    end
  end
end
