
require 'rails_helper'

RSpec.describe RandomCountryFacade, type: :facade do
  describe '.random_country' do
    it 'returns a random country' do
      stub_request(:get, 'https://restcountries.com/v3.1/all')
        .to_return(
          status: 200,
          body: File.read('spec/fixtures/random_country.json'),
          headers: { 'Content-Type' => 'application/json' }
        )
      random_country = RandomCountryFacade.random_country

      expect(random_country).to be_a(String) 
    end
  end
end
