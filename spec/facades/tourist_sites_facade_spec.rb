require "rails_helper"
require "webmock/rspec"

RSpec.describe TouristSitesFacade, type: :facade do
  describe ".destinations" do
    let(:lng) { 10.0 }
    let(:lat) { 20.0 }
    let(:geolocation) { LatLng.new(lng: lng, lat: lat) }

    before do
      stub_request(:get, "https://api.geoapify.com/v2/places")
        .with(
          query: {
            "categories" => "tourism",
            "filter" => "circle:#{lng},#{lat},10000",
            "apiKey" => Rails.application.credentials.dig(:geoapify, :api_key)
          }
        )
        .to_return(
          status: 200,
          body: File.read("spec/fixtures/destinations_response.json"),
          headers: { "Content-Type" => "application/json" }
        )
    end

    it "returns destinations based on the provided coordinates" do
      destinations = TouristSitesFacade.destinations(geolocation)

      expect(destinations).to be_an(Array)
      expect(destinations).not_to be_empty
      expect(destinations.first).to be_an_instance_of(TouristSite)
      expect(destinations.first.name).to eq("Ruines du château")
      expect(destinations.first.address).to eq("Ruines du château, D 37, 23460 Le Monteil-au-Vicomte, France")
      expect(destinations.first.place_id).to eq("514f4e194fdd03ff3f599c1feab7f0f64640f00102f9016e1b800a000000009203125275696e6573206475206368c3a274656175")
    end
  end
end
