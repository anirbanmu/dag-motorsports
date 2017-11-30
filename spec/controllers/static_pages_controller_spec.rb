require 'rails_helper'

describe StaticPagesController do
  describe 'home' do
    it 'is successful' do
      get :home
      expect(response).to be_success
      expect(response).to render_template(:home)
    end
  end

  describe 'help' do
    it 'is successful' do
      get :help
      expect(response).to be_success
      expect(response).to render_template(:help)
    end
  end
end
