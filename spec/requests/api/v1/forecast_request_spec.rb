require 'rails_helper'

RSpec.describe 'Forecast API' do
  describe 'getting a forecast for a given location' do
    describe 'happy path' do
      it 'returns the json data of the forecast', :vcr do
        get "/api/v1/forecast?location=Bozeman,MT"

        forecast = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(200)
        expect(forecast).to be_a Hash
        expect(forecast).to have_key :data
        expect(forecast[:data]).to have_key :id
        expect(forecast[:data]).to have_key :type
        expect(forecast[:data][:type]).to eq("forecast")
        expect(forecast[:data]).to have_key :attributes
        expect(forecast[:data][:attributes]).to be_a Hash

        expect(forecast[:data][:attributes]).to have_key :current_weather
        expect(forecast[:data][:attributes][:current_weather]).to be_a Hash

        expect(forecast[:data][:attributes]).to have_key :daily_weather
        expect(forecast[:data][:attributes][:daily_weather]).to be_an Array
        expect(forecast[:data][:attributes][:daily_weather].length).to eq(5)

        expect(forecast[:data][:attributes]).to have_key :hourly_weather
        expect(forecast[:data][:attributes][:hourly_weather]).to be_an Array
        expect(forecast[:data][:attributes][:hourly_weather].length).to eq(8)
      end
    end

    describe 'sad path' do
      it 'returns a 400 error and message if no location is specified', :vcr do
        get "/api/v1/forecast"

        no_forecast = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(no_forecast).to have_key :error
        expect(no_forecast[:error]).to eq("Missing location.")
      end
    end
  end
end
