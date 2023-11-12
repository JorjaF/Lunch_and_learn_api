require 'rails_helper'
require 'webmock/rspec'

RSpec.describe 'API V1 Recipes', type: :request do
  describe 'GET /api/v1/recipes' do
    let(:country) { 'Chinese' } 

    before do
      app_id = Rails.application.credentials.dig(:edamam, :app_id)
      app_key = Rails.application.credentials.dig(:edamam, :app_key)
      stub_request(:get, "https://api.edamam.com/api/recipes/v2?type=public&app_id=#{app_id}&app_key=#{app_key}&cuisineType=Chinese")
        .to_return(
          status: 200,
          body: File.read('spec/fixtures/recipes_by_country.json'),
          headers: { 'Content-Type' => 'application/json' }
        )
      stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=#{app_id}&app_key=#{app_key}&cuisineType=butt&type=public").
        with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.11'
          }).
        to_return(status: 200, body: File.read("spec/fixtures/no_value.json"), headers: {})


      stub_request(:get, "https://restcountries.com/v3.1/all").
        with(
          headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v2.7.11'
          }).
        to_return(status: 200, body: File.read("spec/fixtures/random_country.json"), headers: {})

      stub_request(:get, "https://api.edamam.com/api/recipes/v2?app_id=#{app_id}&app_key=#{app_key}&cuisineType=Greek&type=public").
        with(
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.11'
          }).
        to_return(status: 200, body: File.read("spec/fixtures/recipes_by_country.json"), headers: {})
    end
    
    it 'returns recipes for a valid country' do

      get "/api/v1/recipes?country=#{country}"

      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)

      expect(json_response['data']).to be_present

      expect(json_response['data']).to include(
        {
          'id' => nil,
          'type' => 'recipe',
          'attributes' => {
            'title' => 'Kimchi Fried Rice',
            'url' => 'https://example.com/dumplings',
            'country' => ["chinese"],
            'image' => 'http://norecipes.com/recipe/kimchi-fried-rice/'
          }
        }
      )
      expect(json_response['data']).not_to include("dietLabels")
      expect(json_response['data']).not_to include("healthLabels")
      expect(json_response['data']).not_to include("cautions")    
    end

    it "returns an empty array if user does not enter a country name, or ask use to choose for the" do
      get "/api/v1/recipes?country=butt"
      json_response = JSON.parse(response.body)

      expect(json_response['data']).to eq([])
    end
    
    it "can get recipes for a random country" do
      allow(RandomCountryFacade).to receive(:random_country).and_return("Greek")
      get "/api/v1/recipes"
      json_response = JSON.parse(response.body)
      expect(json_response['data']).to be_present
      expect(json_response['data']).to include(
        {
          'id' => nil,
          'type' => 'recipe',
          'attributes' => {
            'title' => 'Kimchi Fried Rice',
            'url' => 'https://example.com/dumplings',
            'country' => ["chinese"],
            'image' => 'http://norecipes.com/recipe/kimchi-fried-rice/'
          }
        }
      )
    end
  end
end
