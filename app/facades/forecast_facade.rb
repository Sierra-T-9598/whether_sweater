class ForecastFacade
  def self.get_forecast(location, units = 'imperial')
    coordinates = CoordinatesFacade.get_coordinates(location)
    forecast = WeatherService.forecast_data(coordinates.lat, coordinates.lng)
    Forecast.new(forecast)
  end
end
