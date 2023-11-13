require "rails_helper"

RSpec.describe CountryImageFacade do
  describe ".country_image" do
    let(:country) { "Laos" }

    it "fetches image data for the country" do
      stub_request(:get, "https://api.unsplash.com/search/photos?query=Laos")
      .with(
        headers: {
        "Accept"=>"*/*",
        "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
        "Authorization"=>"Client-ID " + Rails.application.credentials.dig(:unsplash, :api_key),
        "User-Agent"=>"Faraday v2.7.11"
        })
        .to_return(
          status: 200,
          body: File.read("spec/fixtures/image_search_response.json"),
          headers: { "Content-Type" => "application/json" }
        )

      image_data = CountryImageFacade.country_image(country)

      expect(image_data).to be_a(Array)
      expect(image_data.first).to be_a(CountryImage)
      
  
      expect(image_data).not_to include(:id)
      expect(image_data).not_to include(:created_at)
      expect(image_data).not_to include(:description)
    end
  end
end
