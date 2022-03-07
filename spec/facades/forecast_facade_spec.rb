require 'rails_helper'

RSpec.describe ForecastFacade do
  describe 'class methods' do
    describe '::get_forecast(location)' do
      it 'returns the forecast data(current, daily, and hourly) for a given location converted to lat/lng', :vcr do
        forecast = ForecastFacade.get_forecast("Bozeman, MT")
        expect(forecast).to be_a Forecast
      end

      it 'does not return uneeded attributes', :vcr do
        forecast = ForecastFacade.get_forecast("Bozeman, MT")
        expect(forecast.current_weather[:pressure].nil?).to eq(true)
        expect(forecast.current_weather[:clouds].nil?).to eq(true)
        expect(forecast.daily_weather[0][:moon_rise].nil?).to eq(true)
        expect(forecast.daily_weather[0][:moon_rise].nil?).to eq(true)
        expect(forecast.hourly_weather[0][:feels_like].nil?).to eq(true)
        expect(forecast.hourly_weather[0][:visibility].nil?).to eq(true)
        expect(forecast.hourly_weather[0][:windgust].nil?).to eq(true)
      end
    end

    describe '::get_forecast_lite(location)' do
      it 'returns abbreviated current forecast data for use in the book-search request', :vcr do
        forecast_lite = ForecastFacade.get_forecast_lite('bozeman, MT')
        expect(forecast_lite).to be_a Hash
        expect(forecast_lite.size).to eq(2)
        expect(forecast_lite).to have_key :summary
        expect(forecast_lite).to have_key :temperature
      end
    end
  end
end
