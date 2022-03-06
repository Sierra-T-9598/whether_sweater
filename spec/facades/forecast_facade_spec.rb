require 'rails_helper'

RSpec.describe ForecastFacade do
  describe 'class methods' do
    describe '::get_forecast(location)' do
      it 'returns the forecast data for a given location converted to lat/lng', :vcr do
        forecast = ForecastFacade.get_forecast("Bozeman, MT")
        expect(forecast).to be_a Forecast
      end
    end
  end
end
