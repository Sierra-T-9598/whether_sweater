class RoadTripFacade
  def self.get_road_trip(origin, destination)
    directions_data = MapService.directions(origin, destination)
    weather_data = ForecastFacade.get_forecast(destination)
    RoadTrip.new(origin, destination, directions_data, weather_data)
  end
end
