class RecipeFacade
  def self.recipes_by_country(country)
    conn = Faraday.new(url: 'https://api.edamam.com/api/recipes/v2') do |faraday|
      faraday.params['type'] = 'public'
      faraday.params['app_id'] = Rails.application.credentials.dig(:edamam, :app_id)
      faraday.params['app_key'] = Rails.application.credentials.dig(:edamam, :app_key)
      faraday.params['cuisineType'] = country
    end
    response = conn.get

    json = JSON.parse(response.body, symbolize_names: true)
    
    json[:hits].map { |recipe| Recipe.new(recipe) }
  end
end
