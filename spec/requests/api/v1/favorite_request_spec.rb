require "rails_helper"
require "webmock/rspec"

RSpec.describe "Favorite API", type: :request do
  let(:user) { User.create!(name: "Eric", email: "EricRocks@luvmymom.com", password: "1234", password_confirmation: "1234") }
  let(:api_key) { user.api_key }
  let(:valid_params) do
    {
      api_key: api_key,
      country: "thailand",
      recipe_link: "https://www.tastingtable.com/...",
      recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
    }
  end

  describe "POST /api/v1/favorites" do
    context "with valid parameters" do
      it "creates a favorite and returns success" do
        post "/api/v1/favorites", params: valid_params, as: :json

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to eq({ "success" => "Favorite added successfully" })
      end
    end

    context "with invalid api_key" do
      let(:invalid_params) do
        {
          api_key: "invalid_key",
          country: "thailand",
          recipe_link: "https://www.tastingtable.com/...",
          recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
        }
      end

      it "returns an error for invalid api_key" do
        post "/api/v1/favorites", params: invalid_params, as: :json

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to eq({ "error" => "Invalid api_key" })
      end
    end
  end

  describe "GET /api/v1/favorites" do
    context "with a valid API key" do
      before do
        Favorite.create!(user: user, recipe_title: "Recipe: Egyptian Tomato Soup", recipe_link: "http://www.thekitchn.com/recipe-egyptian-tomato-soup-weeknight....", country: "egypt")
        
        get "/api/v1/favorites", params: { api_key: api_key }
      end

      it "returns a successful response" do
        expect(response).to have_http_status(200)
      end
    end

    context "with invalid information" do
      let(:invalid_params) do
        {
          api_key: "invalid_key",
          country: "",
          recipe_link: "https://www.tastingtable.com/...",
          recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
        }
        it "returns an error for invalid api_key" do
          post "/api/v1/favorites", params: invalid_params, as: :json

          expect(response).to have_http_status(:unauthorized)
          expect(JSON.parse(response.body)).to eq({ "error" => "Invalid api_key" })
        end
      end
    end
  end
end
