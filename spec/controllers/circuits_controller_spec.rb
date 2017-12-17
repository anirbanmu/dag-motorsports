require 'rails_helper'

RSpec.describe CircuitsController, type: :controller do
  let(:circuit) { create(:circuit) }

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { id: circuit }
      expect(response).to have_http_status(:success)
    end
  end
end
