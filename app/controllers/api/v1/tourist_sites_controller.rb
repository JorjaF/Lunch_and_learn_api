class Api::V1::TouristSitesController < ApplicationController
  def index
    country = params[:country]
    capital = CountriesFacade.capital(country)
    location = CountriesFacade.latlng(capital)
    tourist_sites = TouristSitesFacade.destinations(location[1], location[0])

    render json: TouristSiteSerializer.new(tourist_sites) 
  end
end
