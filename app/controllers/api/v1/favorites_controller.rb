class Api::V1::FavoritesController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    favorite = Favorite.new(favorite_params)
    if user
      favorite.user_id = user.id
      if favorite.save
        render json: { success: "Favorite added successfully" }, status: :created
      else
        render json: { error: favorite.errors.full_messages.to_sentence }, status: :unprocessable_entity
      end
    else
      render json: { error: "Invalid api_key" }, status: :unauthorized
    end
  end

  private

  def favorite_params
    params.permit(:country, :recipe_link, :recipe_title)
  end
end
