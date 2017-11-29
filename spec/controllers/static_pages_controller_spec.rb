require 'rails_helper'

describe StaticPagesController do
  describe 'home' do
    it 'has a 200 status code' do
      get :home
      expect(response.code).to eq('200')
    end
  end

  describe 'help' do
    it 'has a 200 status code' do
      get :help
      expect(response.code).to eq('200')
    end
  end
end
