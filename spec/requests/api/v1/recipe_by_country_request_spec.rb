require 'rails_helper'
require 'webmock/rspec'

RSpec.describe 'API V1 Recipes', type: :request do
  describe 'GET /api/v1/recipes' do
    let(:country) { 'Chinese' } 

    before do
      stub_request(:get, 'https://api.edamam.com/api/recipes/v2?type=public&app_id=fc7547dd&app_key=400d1c90d81cbfda83f899e56246e802&cuisineType=Chinese')
        .to_return(
          status: 200,
          body: File.read('spec/fixtures/recipes_by_country.json'),
          headers: { 'Content-Type' => 'application/json' }
        )
    end
    it 'returns recipes for Chinese for a happy path' do

      get "/api/v1/recipes?country=#{country}"

      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)

      expect(json_response['data']).to be_present
      expect(json_response['data']).to be_an(Array)
      expect(json_response['data'].count).to eq(20)
      expect(json_response['data']).to include(
        {
          'id' => nil,
          'type' => 'recipe',
          'attributes' => {
            'title' => 'Kimchi Fried Rice',
            'url' => 'https://example.com/dumplings',
            'country' => ["chinese"],
            'image_url' => 'http://norecipes.com/recipe/kimchi-fried-rice/'
          }
        }
      )
      expect(json_response['data']).not_to include("dietLabels")
      expect(json_response['data']).not_to include("healthLabels")
      expect(json_response['data']).not_to include("cautions")    
    end
  end
end
