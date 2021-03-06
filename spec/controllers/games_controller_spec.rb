require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let(:game) { create(:game) }

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: game }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
