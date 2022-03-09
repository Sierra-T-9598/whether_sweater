require 'rails_helper'

RSpec.describe 'Sessions API' do
  describe 'User login request' do
    describe 'happy path- user has verified credentials' do
      it 'returns the user json object that has already been persisted' do
        user = User.create!(email: 'test@email.com', password: 'password', password_confirmation: 'password')
        session_params = {
                        email: 'test@email.com',
                        password: 'password'
                        }
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/sessions", headers: headers, params: JSON.generate(session_params)
        found_user = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(200)
        expect(found_user).to have_key(:data)
        expect(found_user[:data]).to have_key(:attributes)
        expect(found_user[:data][:attributes]).to have_key(:email)
        expect(found_user[:data][:attributes]).to have_key(:private_api_key)
      end
    end

    describe 'sad path- user does not exist or cannot be verified' do
      it 'returns a 400 status and NOT too descriptive error' do
        user = User.create!(email: 'test@email.com', password: 'password', password_confirmation: 'password')
        session_params = {
                        email: 'wrong@email.com',
                        password: 'password'
                        }
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/sessions", headers: headers, params: JSON.generate(session_params)
        no_user = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(no_user).to have_key(:error)
        expect(no_user[:error]).to eq("Email and/or password is incorrect")
      end

      it 'returns a 400 error and not TOO descriptive error message', :vcr do
        session_params = {
                        email: 'test@email.com',
                        password: 'password'
                        }
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/sessions", headers: headers, params: JSON.generate(session_params)
        no_user = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(no_user).to have_key(:error)
        expect(no_user[:error]).to eq("Email and/or password is incorrect")
      end
    end
  end
end
