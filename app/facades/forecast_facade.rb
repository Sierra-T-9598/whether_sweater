class ForecastFacade
  def self.get_forecast(location, units = 'imperial')
    coordinates = CoordinatesFacade.get_coordinates(location)
    forecast = WeatherService.forecast_data(coordinates.lat, coordinates.lng)
    Forecast.new(forecast)
  end

  def self.get_forecast_lite(location, units = 'imperial')
    coordinates = CoordinatesFacade.get_coordinates(location)
    forecast = WeatherService.forecast_data(coordinates.lat, coordinates.lng)
    forecast = Forecast.new(forecast)
    forecast.forecast_lite
  end
end
