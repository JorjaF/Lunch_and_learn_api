require 'rails_helper'

RSpec.describe 'Api::V1::SessionsController', type: :request do
  describe 'POST /api/v1/sessions' do
    let(:user) do
      User.create!(
        name: 'Odell',
        email: 'goodboy@ruffruff.com',
        password: 'treats4lyf',
        password_confirmation: 'treats4lyf'
      )
    end

    context 'with valid credentials' do
      it 'returns user data and api key' do
        post '/api/v1/sessions', params: { email: user.email, password: 'treats4lyf' }

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)

        expect(json_response).to include('data')
        expect(json_response['data']).to include(
          'type' => 'user',
          'id' => user.id,
          'attributes' => {
            'name' => user.name,
            'email' => user.email,
            'api_key' => user.api_key
          }
        )
      end
    end

    context 'with invalid credentials' do
      it 'returns unauthorized error' do
        post '/api/v1/sessions', params: { email: 'invalid_email', password: 'invalid_password' }

        expect(response).to have_http_status(:unauthorized)
        json_response = JSON.parse(response.body)

        expect(json_response).to include('error' => 'Invalid credentials')
      end
    end
  end
end
