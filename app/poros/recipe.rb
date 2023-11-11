class Recipe
  attr_reader :title, :url, :country, :image

  def initialize(data)
    @title = data[:recipe][:label]
    @url = data[:recipe][:url]
    @country = data[:recipe][:cuisineType]
    @image = data[:recipe][:image]
  end
end
