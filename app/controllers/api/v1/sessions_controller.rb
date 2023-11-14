class Api::V1::SessionsController < ApplicationController
  before_action :authenticate_user, only: [:destroy]

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      render json: user_response(user), status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  def authenticate_user
    api_key = request.headers['HTTP_API_KEY']

    unless api_key && (user = User.find_by(api_key: api_key))
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def user_response(user)
    {
      data: {
        type: 'user',
        id: user.id,
        attributes: {
          name: user.name,
          email: user.email,
          api_key: user.api_key
        }
      }
    }
  end
end
