require "rails_helper"
require "webmock/rspec"

RSpec.describe "TouristSites API", type: :request do
  describe "GET /api/v1/tourist_sites" do
    context "when providing a valid country for Happy Path" do
      let(:happy_path_country) { "France" }

      before do
  
        stub_request(:get, "https://restcountries.com/v3.1/name/#{happy_path_country}?fields=capital")
          .to_return(
            status: 200,
            body: File.read("spec/fixtures/country_capital_response.json"),
            headers: { "Content-Type" => "application/json" }
          )
        stub_request(:get, "https://restcountries.com/v3.1/capital/Paris?fields=latlng").
          with(
            headers: {
            "Accept"=>"*/*",
            "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
            "User-Agent"=>"Faraday v2.7.11"
            }).
          to_return(status: 200, body: File.read("spec/fixtures/latlng_response.json"), headers: {})

        stub_request(:get, "https://api.geoapify.com/v2/places?apiKey=c5962bf636cc4f41a69ab554ae39eb4b&categories=tourism&filter=circle:2.0,46.0,10000").
          with(
            headers: {
          "Accept"=>"*/*",
          "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "User-Agent"=>"Faraday v2.7.11"
            }).
          to_return(status: 200, body: File.read("spec/fixtures/destinations_response.json"), headers: {})

      end

      it "returns tourist sites for a valid country" do
        get "/api/v1/tourist_sites?country=#{happy_path_country}"

        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)

        expect(json_response).to include("data")
        expect(json_response["data"]).to be_an(Array)
        expect(json_response["data"].first).to include("id")
        expect(json_response["data"].first).to include("type")
        expect(json_response["data"].first).to include("attributes")
        expect(json_response["data"].first["attributes"]).to include("name")
        expect(json_response["data"].first["attributes"]).to include("address")
        expect(json_response["data"].first["attributes"]).to include("place_id")
      end
    end

    context "when providing an invalid country for Sad Path" do
      let(:sad_path_country) { "Antarctica" }

      before do
        stub_request(:get, "https://restcountries.com/v3.1/name/Antarctica?fields=capital").
          with(
            headers: {
          "Accept"=>"*/*",
          "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "User-Agent"=>"Faraday v2.7.11"
            }).
          to_return(status: 200, body: File.read("spec/fixtures/country_capital_no_response.json"), headers: {})
      end

      it "returns an error for an invalid country" do
        get "/api/v1/tourist_sites?country=#{sad_path_country}"

        expect(response).to have_http_status(:not_found)

        json_response = JSON.parse(response.body)

        expect(json_response).to include("error")
        expect(json_response["error"]).to eq("Capital of #{sad_path_country} not found")
      end
    end
  end
end
