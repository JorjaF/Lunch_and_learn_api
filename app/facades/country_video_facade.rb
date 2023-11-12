class CountryVideoFacade
  def self.country_video(country)
    conn = Faraday.new(url: 'https://www.googleapis.com/youtube/v3/search') do |faraday|
      faraday.params['part'] = 'snippet'
      faraday.params['channelId'] = 'UCluQ5yInbeAkkeCndNnUhpw'
      faraday.params['q'] = country
      faraday.params['key'] = Rails.application.credentials.dig(:youtube, :key)
      faraday.params['maxResults'] = 1
    end
    
    response = conn.get

    json = JSON.parse(response.body, symbolize_names: true) 
    json.dig(:items).nil? ? [] : json.dig(:items).map { |video| CountryVideo.new(video) }
  end
end
