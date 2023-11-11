class Recipe
  attr_reader :title, :url, :country, :image_url

  def initialize(data)
   
    @title = data[:recipe][:label]
    @url = data[:recipe][:url]
    @country = data[:recipe][:cuisineType]
    @image_url = data[:recipe][:image]
  end
end
