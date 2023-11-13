class CountriesFacade
  def self.capital(country)
    conn = Faraday.new(url: "https://restcountries.com/v3.1/name/#{country}") do |faraday|
      faraday.params["fields"] = "capital"
      
    end
    response = conn.get

    json = JSON.parse(response.body, symbolize_names: true)
    
    json.first[:capital].first
  end
end
