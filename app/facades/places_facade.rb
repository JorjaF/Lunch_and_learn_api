class PlacesFacade
  def places
    conn = Faraday.new(url: 'https://api.geoapify.com/v2/places') do |faraday|
      faraday.params['apiKey'] = Rails.application.credentials.dig(:geoapify, :api_key)
      
    end
    response = conn.get

    json = JSON.parse(response.body, symbolize_names: true)
    
    json[:hits].map { |recipe| Recipe.new(recipe) }
  end
end
