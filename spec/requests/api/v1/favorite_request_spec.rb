require "rails_helper"
require "webmock/rspec"

RSpec.describe "Favorite API", type: :request do
  describe "POST /api/v1/favorites" do
    let(:user) do
      User.create!(
        name: "Eric",
        email: "EricRocks@luvmymom.com",
        password: "1234",
        password_confirmation: "1234"
      )
    end
    let(:valid_api_key) { user.api_key }
    let(:invalid_api_key) { "invalid_key" }

    context "with valid parameters" do
      let(:valid_params) do
        {
          api_key: valid_api_key,
          country: "thailand",
          recipe_link: "https://www.tastingtable.com/...",
          recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
        }
      end

      it "creates a favorite and returns success" do
        post "/api/v1/favorites", params: valid_params, as: :json

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to eq({ "success" => "Favorite added successfully" })
      end
    end

    context "with invalid api_key" do
      let(:invalid_params) do
        {
          api_key: invalid_api_key,
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
end
