class TouristSitesFacade
  def self.destinations(geolocation)
    conn = Faraday.new(url: "https://api.geoapify.com/v2/places") do |faraday|
      faraday.params["categories"] = "tourism"
      faraday.params["filter"] = "circle:#{geolocation.lng},#{geolocation.lat},10000"
      faraday.params["apiKey"] = Rails.application.credentials.dig(:geoapify, :api_key)
    end
    response = conn.get

    json = JSON.parse(response.body, symbolize_names: true)
    
    json[:features].map { |tourist_site| TouristSite.new(tourist_site[:properties]) }
  end
end
