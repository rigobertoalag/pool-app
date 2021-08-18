require 'rails_helper'

RSpec.describe "Welcomes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/welcome/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /app" do
    it "returns http success" do
      get "/welcome/app"
      expect(response).to have_http_status(:success)
    end
  end

end
