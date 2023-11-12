require 'rails_helper'
require 'webmock/rspec'

RSpec.describe 'Learning Resources API', type: :request do
  describe 'GET /api/v1/learning_resources' do
    let(:country_name) { 'Laos' }

    before do
      key = Rails.application.credentials.dig(:youtube, :key)
      client = Rails.application.credentials.dig(:unsplash, :api_key)
      youtube_stub = 
      stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{Rails.application.credentials.dig(:youtube,:key)}&maxResults=1&part=snippet&q=Laos")
      .with(
        headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v2.7.11'
        })
      .to_return( 
            status: 200,
            body: File.read('spec/fixtures/youtube_video_response.json'),
            headers: { 'Content-Type' => 'application/json' }
          )

      image_search_stub = 
        stub_request(:get, "https://api.unsplash.com/search/photos?query=Laos")
          .with(
            headers: { "Authorization" => "Client-ID " + client }
          )
          .to_return(
            status: 200,
            body: File.read('spec/fixtures/image_search_response.json'),
            headers: { 'Content-Type' => 'application/json' }
          )
    end

    it 'returns learning resources for a specific country' do
      get "/api/v1/learning_resources?country_name=#{country_name}"

      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)

      expect(json_response).to include('data')

      expect(json_response['data']).to include(
        'id' => nil,
        'type' => 'learning_resource')
      expect(json_response['data']['attributes']).to include('country' => country_name)
      expect(json_response['data']['attributes']).to include('video')
      expect(json_response['data']['attributes']['video']).to include('title')
      expect(json_response['data']['attributes']['video']).to include('video_id')
      expect(json_response['data']['attributes']).to include('images')
      expect(json_response['data']['attributes']['images']).to be_an(Array)
      expect(json_response['data']['attributes']['images'].first).to include('alt_tag')
      expect(json_response['data']['attributes']['images'].first).to include('url')

      expect(json_response['data']['attributes']['images'].first).not_to include('description')
    end

    it 'returns an empty response when no videos or images are found' do
      client = Rails.application.credentials.dig(:unsplash, :api_key)
      country_name = 'fdsfafvdcs'
      youtube_stub = 
      stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{Rails.application.credentials.dig(:youtube,:key)}&maxResults=1&part=snippet&q=fdsfafvdcs")
      .with(
        headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v2.7.11'
        })
      .to_return( 
            status: 200,
            body: File.read('spec/fixtures/no_value.json'),
            headers: { 'Content-Type' => 'application/json' }
          )

      image_search_stub = 
        stub_request(:get, "https://api.unsplash.com/search/photos?query=fdsfafvdcs")
          .with(
            headers: { "Authorization" => "Client-ID " + client }
          )
          .to_return(
            status: 200,
            body: File.read('spec/fixtures/unsplash_no_value.json'),
            headers: { 'Content-Type' => 'application/json' }
          )

      get "/api/v1/learning_resources?country_name=fdsfafvdcs"

      expect(response).to have_http_status(:ok)

      json_response = JSON.parse(response.body)


      expect(json_response).to include('data')
      expect(json_response['data']).to include(
        'id' => nil,
        'type' => 'learning_resource',
        'attributes' => {
          'country' => 'fdsfafvdcs',
          'video' => {},
          'images' => []
        }
      )
    end
  end
end
