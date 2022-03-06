require 'rails_helper'

RSpec.describe WeatherService do
  describe 'class methods' do
    describe '::forecast_data(lat, long, units)' do
      it 'returns the json data for the current, daily, and hourly weather', :vcr do
        response = WeatherService.forecast_data(45.679294, -111.046611)

        expect(response).to be_a Hash
        expect(response).to have_key :current
        expect(response[:current]).to be_a Hash

        expect(response).to have_key :hourly
        expect(response[:hourly]).to be_an Array

        expect(response).to have_key :daily
        expect(response[:daily]).to be_an Array
      end
    end
  end
end
