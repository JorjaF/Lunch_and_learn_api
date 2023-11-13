require 'rails_helper'
require 'webmock/rspec'

RSpec.describe CountriesFacade, type: :facade do
  describe '.capital' do
    let(:country) { 'France' }

    before do
      stub_request(:get, "https://restcountries.com/v3.1/name/#{country}?fields=capital")
        .to_return(
          status: 200,
          body: File.read('spec/fixtures/country_capital_response.json'),
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'returns the capital of the specified country' do
      capital = CountriesFacade.capital(country)

      expect(capital).to eq('Paris')
    end
  end

  describe '.capital' do
    let(:city) { 'Paris' }

    before do
      stub_request(:get, "https://restcountries.com/v3.1/name/#{city}?fields=latlng")
        .to_return(
          status: 200,
          body: File.read('spec/fixtures/latlng_response.json'),
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'returns the capital of the specified country' do
      latlng = CountriesFacade.latlng(city)

      expect(latlng).to eq([46.0, 2.0])
    end
  end
end
