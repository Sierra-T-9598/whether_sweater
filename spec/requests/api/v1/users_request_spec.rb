require 'rails_helper'

RSpec.describe 'Users API' do
  describe 'user registration' do
    describe 'happy path' do
      it 'creates a user and generates unique api key associated with user' do
        user_params = {
                    email: 'test@email.com',
                    password: 'password',
                    password_confirmation: 'password'
                    }
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/users", headers: headers, params: JSON.generate(user_params)
        created_user = JSON.parse(response.body, symbolize_names: true)
  
        expect(response.status).to eq(201)
        expect(created_user).to have_key(:data)
        expect(created_user[:data][:type]).to eq("users")
        expect(created_user[:data][:attributes]).to have_key(:email)
        expect(created_user[:data][:attributes]).to have_key(:private_api_key)

      end
    end

    describe 'sad path' do
      describe 'passwords do not match' do
        it 'returns a 400 status and description of what went wrong' do
          user_params = {
                      email: 'test@email.com',
                      password: 'password',
                      password_confirmation: 'better_password'
                      }
          headers = {"CONTENT_TYPE" => "application/json"}
          post "/api/v1/users", headers: headers, params: JSON.generate(user_params)
          no_user = JSON.parse(response.body, symbolize_names: true)

          expect(response.status).to eq(400)
          expect(no_user).to have_key(:error)
          expect(no_user[:error]).to eq("Passwords do not match or field is missing, please try again")
        end
      end

      describe 'email has already been used' do
        it 'returns a 400 status and description of what went wrong' do
          other_user = User.create!(email: 'test@email.com', password: 'mine', password_confirmation: 'mine')
          user_params = {
                      email: 'test@email.com',
                      password: 'password',
                      password_confirmation: 'password'
                      }
          headers = {"CONTENT_TYPE" => "application/json"}
          post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

          no_user = JSON.parse(response.body, symbolize_names: true)

          expect(response.status).to eq(400)
          expect(no_user).to have_key(:error)
          expect(no_user[:error]).to eq("Email has already been taken, please try again")
        end
      end

      describe 'field missing' do
        it 'returns a 400 status if password_confirmation is missing' do
          user_params = ({
                      email: 'test@email.com',
                      password: 'password',
                      })
          headers = {"CONTENT_TYPE" => "application/json"}
          post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

          no_user = JSON.parse(response.body, symbolize_names: true)

          expect(response.status).to eq(400)
          expect(no_user).to have_key(:error)
          expect(no_user[:error]).to eq("Passwords do not match or field is missing, please try again")
        end

        it 'returns a 400 status if password is missing' do
          user_params = ({
                      email: 'test@email.com',
                      password_confirmation: 'password',
                      })
          headers = {"CONTENT_TYPE" => "application/json"}
          post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

          no_user = JSON.parse(response.body, symbolize_names: true)

          expect(response.status).to eq(400)
          expect(no_user).to have_key(:error)
          expect(no_user[:error]).to eq("Passwords do not match or field is missing, please try again")
        end

        it 'returns a 400 status if email is missing' do
          user_params = ({
                      password: 'password',
                      password_confirmation: 'password',
                      })
          headers = {"CONTENT_TYPE" => "application/json"}
          post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

          no_user = JSON.parse(response.body, symbolize_names: true)

          expect(response.status).to eq(400)
          expect(no_user).to have_key(:error)
          expect(no_user[:error]).to eq("Missing field(s), please try again")
        end
      end
    end
  end
end
