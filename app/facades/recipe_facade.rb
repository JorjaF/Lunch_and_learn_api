class RecipeFacade
  def self.recipes_by_country(country)
    conn = Faraday.new(url: 'https://api.edamam.com/api/recipes/v2') do |faraday|
      faraday.params['type'] = 'public'
      faraday.params['app_id'] = 'fc7547dd'
      faraday.params['app_key'] = '400d1c90d81cbfda83f899e56246e802'
      faraday.params['cuisineType'] = country
    end
    response = conn.get

    json = JSON.parse(response.body, symbolize_names: true)
    
    json[:hits].map { |recipe| Recipe.new(recipe) }
  end
end
