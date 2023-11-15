class Api::V1::RecipesController < ApplicationController
  def index
    country = params[:country].present? ? params[:country] : RandomCountryFacade.random_country

    recipes = RecipeFacade.recipes_by_country(country)

    render json: RecipeSerializer.new(recipes) 
  end
end
