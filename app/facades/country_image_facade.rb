class CountryImageFacade
  def self.country_image(country)
    conn = Faraday.new(url: "https://api.unsplash.com/search/photos") do |faraday|
      faraday.params["query"] = country
      faraday.headers["Authorization"] = "Client-ID " + Rails.application.credentials.dig(:unsplash, :api_key)
    end
    response = conn.get
  
    json = JSON.parse(response.body, symbolize_names: true)
    json[:results].map { |image| CountryImage.new(image) }
    
  end
end
