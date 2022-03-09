require 'rails_helper'

RSpec.describe "Road Trip API" do
  describe 'request road trip data' do
    describe 'happy path' do
      it 'returns the road trip data as a json object', :vcr do
        user = User.create!(email: "user@email.com", password: '123', password_confirmation: "123",
                private_api_key: "1029384756")
        road_trip_params = {
          origin: "Bozeman,MT",
          destination: "Lyons,CO",
          private_api_key: "1029384756"
        }
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/road_trip", headers: headers, params: JSON.generate(road_trip_params)
        created_road_trip = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(201)
        expect(created_road_trip).to be_a Hash
        expect(created_road_trip).to_not have_key :private_api_key

        expect(created_road_trip).to have_key :data
        expect(created_road_trip[:data].size).to eq(3)

        expect(created_road_trip[:data]).to_not have_key :private_api_key
        expect(created_road_trip[:data]).to have_key :attributes
        expect(created_road_trip[:data][:attributes]).to be_a Hash
        expect(created_road_trip[:data][:attributes].size).to eq(4)

        expect(created_road_trip[:data][:attributes]).to_not have_key :private_api_key

        expect(created_road_trip[:data][:attributes]).to have_key :start_city
        expect(created_road_trip[:data][:attributes][:start_city]).to eq(road_trip_params[:origin])

        expect(created_road_trip[:data][:attributes]).to have_key :end_city
        expect(created_road_trip[:data][:attributes][:end_city]).to eq(road_trip_params[:destination])

        expect(created_road_trip[:data][:attributes]).to have_key :travel_time
        expect(created_road_trip[:data][:attributes][:travel_time]).to be_a String

        expect(created_road_trip[:data][:attributes]).to have_key :weather_at_eta
        expect(created_road_trip[:data][:attributes][:weather_at_eta]).to be_a Hash
        expect(created_road_trip[:data][:attributes][:weather_at_eta].size).to eq(2)

        expect(created_road_trip[:data][:attributes][:weather_at_eta]).to have_key :temperature
        expect(created_road_trip[:data][:attributes][:weather_at_eta][:temperature]).to_not eq(nil)

        expect(created_road_trip[:data][:attributes][:weather_at_eta]).to have_key :conditions
        expect(created_road_trip[:data][:attributes][:weather_at_eta][:conditions]).to be_a String
      end
    end

    describe 'sad paths' do
      describe 'request is for an impossible route by ground' do
        it 'returns a json object of trip data with an empty weather hash and imposslbe travel time,', :vcr do
          user = User.create!(email: "user@email.com", password: '123', password_confirmation: "123",
                  private_api_key: "1029384756")
          road_trip_params = {
            origin: "Bozeman,MT",
            destination: "London, England",
            private_api_key: "1029384756"
          }
          headers = {"CONTENT_TYPE" => "application/json"}
          post "/api/v1/road_trip", headers: headers, params: JSON.generate(road_trip_params)
          created_road_trip = JSON.parse(response.body, symbolize_names: true)

          expect(response.status).to eq(201)
          expect(created_road_trip).to be_a Hash

          expect(created_road_trip).to have_key :data
          expect(created_road_trip[:data].size).to eq(3)

          expect(created_road_trip[:data]).to have_key :attributes
          expect(created_road_trip[:data][:attributes]).to be_a Hash
          expect(created_road_trip[:data][:attributes].size).to eq(4)

          expect(created_road_trip[:data][:attributes]).to have_key :start_city
          expect(created_road_trip[:data][:attributes][:start_city]).to eq(road_trip_params[:origin])

          expect(created_road_trip[:data][:attributes]).to have_key :end_city
          expect(created_road_trip[:data][:attributes][:end_city]).to eq(road_trip_params[:destination])

          expect(created_road_trip[:data][:attributes]).to have_key :travel_time
          expect(created_road_trip[:data][:attributes][:travel_time]).to eq("Impossible")

          expect(created_road_trip[:data][:attributes]).to have_key :weather_at_eta
          expect(created_road_trip[:data][:attributes][:weather_at_eta]).to eq({})
        end
      end

      describe 'request made without an api key' do
        it 'returns an error json object with 401 code and unauthorized message', :vcr do
          user = User.create!(email: "user@email.com", password: '123', password_confirmation: "123",
                  private_api_key: "1029384756")
          road_trip_params = {
            origin: "Bozeman,MT",
            destination: "Lyons,CO"
          }
          headers = {"CONTENT_TYPE" => "application/json"}
          post "/api/v1/road_trip", headers: headers, params: JSON.generate(road_trip_params)
          error = JSON.parse(response.body, symbolize_names: true)

          expect(response.status).to eq(401)
          expect(error).to have_key :error
          expect(error[:error]).to eq("You are not authorized")
        end

        describe 'request made with incorrect/invalid key' do
          it 'returns 401 unauthorized', :vcr do
            user = User.create!(email: "user@email.com", password: '123', password_confirmation: "123",
                    private_api_key: "1029384756")
            road_trip_params = {
              origin: "Bozeman,MT",
              destination: "Lyons,CO",
              private_api_key: '4872364287t42'
            }
            headers = {"CONTENT_TYPE" => "application/json"}
            post "/api/v1/road_trip", headers: headers, params: JSON.generate(road_trip_params)
            error = JSON.parse(response.body, symbolize_names: true)

            expect(response.status).to eq(401)
            expect(error).to have_key :error
            expect(error[:error]).to eq("You are not authorized")
          end
        end

        describe 'origin or destination missing from request' do
          it 'returns a 400 error and invalid params message', :vcr do
            user = User.create!(email: "user@email.com", password: '123', password_confirmation: "123",
                    private_api_key: "1029384756")
            road_trip_params = {
              origin: "Bozeman,MT",
              private_api_key: '10293847756'
            }
            headers = {"CONTENT_TYPE" => "application/json"}
            post "/api/v1/road_trip", headers: headers, params: JSON.generate(road_trip_params)
            error = JSON.parse(response.body, symbolize_names: true)

            expect(response.status).to eq(400)
            expect(error).to have_key :error
            expect(error[:error]).to eq("You're missing a vital component for planning a road trip!")
          end
        end
      end
    end
  end
end
