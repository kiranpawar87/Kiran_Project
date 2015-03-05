require 'rails_helper'

RSpec.describe HangmanController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #admin_page" do
    it "returns http success" do
      get :admin_page
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #user_game" do
    it "returns http success" do
      get :user_game
      expect(response).to have_http_status(:success)
    end
  end

end
