class RandomCountryFacade
  def self.random_country
    conn = Faraday.new(url: "https://restcountries.com/v3.1/all") 
    response = conn.get

    json = JSON.parse(response.body, symbolize_names: true)
    
    json.map { |country| country[:name][:common]}
      .sample
  end
end
