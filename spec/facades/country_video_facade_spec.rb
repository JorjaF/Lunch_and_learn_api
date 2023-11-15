require "rails_helper"
require "webmock/rspec"


RSpec.describe CountryVideoFacade do
  describe ".country_video" do
    let(:country) { "Laos" }

    it "fetches video data for the country" do
      stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{Rails.application.credentials.dig(:youtube,:key)}&maxResults=1&part=snippet&q=Laos")        .with(
          query:{
            "part" => "snippet",
            "channelId" => "UCluQ5yInbeAkkeCndNnUhpw",
            "q" => country,
            "key" => Rails.application.credentials.dig(:youtube, :key)
          }
        )
        .to_return(
          status: 200,
          body: File.read("spec/fixtures/youtube_video_response.json"),
          headers: { "Content-Type" => "application/json" }
        )
      video_data = CountryVideoFacade.country_video(country)

  
      expect(video_data.first).to be_a(CountryVideo)

      expect(video_data).not_to include(:kind)
      expect(video_data).not_to include(:etag)
      expect(video_data).not_to include(:nextPageToken)
      expect(video_data).not_to include(:regionCode)
    end
  end
end
