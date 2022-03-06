class ForecastFacade
  def self.get_forecast(location)
    coordinates = CoordinatesFacade.get_coordinates(location)
    forecast = WeatherService.forecast_data(coordinates.lat, coordinates.lng)
    Forecast.new(forecast)
  end
end 
