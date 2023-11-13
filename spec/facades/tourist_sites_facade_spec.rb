require 'rails_helper'
require 'webmock/rspec'

RSpec.describe TouristSitesFacade, type: :facade do
  describe '.destinations' do
    let(:lng) { 10.0 }
    let(:lat) { 20.0 }

    before do
      stub_request(:get, "https://api.geoapify.com/v2/places")
        .with(
          query: {
            'categories' => 'tourism',
            'filter' => "circle:#{lng},#{lat},10000",
            'apiKey' => Rails.application.credentials.dig(:geoapify, :api_key)
          }
        )
        .to_return(
          status: 200,
          body: File.read('spec/fixtures/destinations_response.json'),
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'returns destinations based on the provided coordinates' do
      destinations = TouristSitesFacade.destinations(lng, lat)

      expect(destinations).to be_an(Array)
      expect(destinations).not_to be_empty
      expect(destinations.first).to be_an_instance_of(TouristSite)
      
    end
  end
end
