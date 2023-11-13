class CountriesFacade
  def self.capital(country)
    conn = Faraday.new(url: "https://restcountries.com/v3.1/name/#{country}") do |faraday|
      faraday.params["fields"] = "capital"
      
    end
    response = conn.get

    json = JSON.parse(response.body, symbolize_names: true)
    
    json.first[:capital].first
  end

  def self.latlng(city)
    conn = Faraday.new(url: "https://restcountries.com/v3.1/capital/#{city}") do |faraday|
    faraday.params["fields"] = "latlng"
    
    end
    response = conn.get

    json = JSON.parse(response.body, symbolize_names: true)
    
    lat_lng = json.first[:latlng]
    LatLng.new(lat: lat_lng[0], lng: lat_lng[1])
  end
end
