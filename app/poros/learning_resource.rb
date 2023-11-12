class LearningResource
  attr_reader :images, :video, :country

  def initialize(video, images, country)
    @country = country
    @video = video
    @images = images
  end
end
