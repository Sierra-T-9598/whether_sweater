require 'rails_helper'

RSpec.describe ForecastFacade do
  describe 'class methods' do
    describe '::get_forecast(location)' do
      it 'returns the forecast data for a given location converted to lat/lng', :vcr do
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
  end
end
