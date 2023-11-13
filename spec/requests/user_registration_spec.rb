# spec/requests/api/v1/users_spec.rb
require "rails_helper"

RSpec.describe "User Registration API", type: :request do
  describe "POST /api/v1/users" do
    let(:valid_attributes) do
      {
        name: "Odell",
        email: "goodboy@ruffruff.com",
        password: "treats4lyf",
        password_confirmation: "treats4lyf"
      }
    end

    context "when valid parameters are provided" do
      it "creates a new user and returns user data with API key" do
        post "/api/v1/users", params: valid_attributes.to_json, headers: { "Content-Type" => "application/json" }

        expect(response).to have_http_status(:created)

        json_response = JSON.parse(response.body)
        expect(json_response["data"]["type"]).to eq("user")
        expect(json_response["data"]["attributes"]["name"]).to eq("Odell")
        expect(json_response["data"]["attributes"]["email"]).to eq("goodboy@ruffruff.com")
        expect(json_response["data"]["attributes"]["api_key"]).to be_present
      end
    end

    context "when email is not unique" do
      before do
        User.create(valid_attributes)
      end

      it "returns an error message with 422 status code" do
        post "/api/v1/users", params: valid_attributes.to_json, headers: { "Content-Type" => "application/json" }

        expect(response).to have_http_status(:unprocessable_entity)

        json_response = JSON.parse(response.body)
        expect(json_response["errors"]).to include("email" => ["has already been taken"])
      end
    end

    context "when passwords do not match" do
      let(:invalid_attributes) { valid_attributes.merge(password_confirmation: "wrong_confirmation") }

      it "returns an error message with 422 status code" do
        post "/api/v1/users", params: invalid_attributes.to_json, headers: { "Content-Type" => "application/json" }

        expect(response).to have_http_status(:unprocessable_entity)

        json_response = JSON.parse(response.body)
        expect(json_response["errors"]).to include("password_confirmation" => ["doesn"t match Password"])
      end
    end
  end
end
