require "rails_helper"

RSpec.describe "User Registration API", type: :request do
  describe "POST /api/v1/users" do
    let(:valid_attributes) do
      {
        name: "Frank",
        email: "yeppan@email.com",
        password: "password",
        password_confirmation: "password"
      }
    end

    context "when valid parameters are provided" do
      it "creates a new user and returns user data with API key" do
        post "/api/v1/users", params: valid_attributes.to_json, headers: { "Content-Type" => "application/json" }

        expect(response).to have_http_status(:created)

        json_response = JSON.parse(response.body)
        expect(json_response["data"]["type"]).to eq("user")
        expect(json_response["data"]["id"]).to be_present
        expect(json_response["data"]["attributes"]["name"]).to eq("Frank")
        expect(json_response["data"]["attributes"]["email"]).to eq("yeppan@email.com")
        expect(json_response["data"]["attributes"]["api_key"]).to be_present
      end
    end

    context "when email is not unique" do
      it "returns an error message with 400 status code" do
        post "/api/v1/users", params: valid_attributes.to_json, headers: { "Content-Type" => "application/json" }
        post "/api/v1/users", params: valid_attributes.to_json, headers: { "Content-Type" => "application/json" }

        expect(response).to have_http_status(:bad_request)

        json_response = JSON.parse(response.body)
        expect(json_response["errors"]).to include("Email has already been taken")
      end
    end

    context "when passwords do not match" do
      let(:invalid_attributes) { valid_attributes.merge(password_confirmation: "wrong_confirmation") }

      it "returns an error message with 400 status code" do
        post "/api/v1/users", params: invalid_attributes.to_json, headers: { "Content-Type" => "application/json" }

        expect(response).to have_http_status(:bad_request)

        json_response = JSON.parse(response.body)
        expect(json_response["errors"]).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
