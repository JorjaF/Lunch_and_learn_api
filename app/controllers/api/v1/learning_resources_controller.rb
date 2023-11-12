class Api::V1::LearningResourcesController < ApplicationController
  def index
    country = params[:country_name]
    
    video = CountryVideoFacade.country_video(country).first
    image = CountryImageFacade.country_image(country)

    learning_resource = LearningResource.new(video, image, country) 
    render json: LearningResourceSerializer.new(learning_resource)
  end
end
