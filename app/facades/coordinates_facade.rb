class CoordinatesFacade
  def self.get_coordinates(location)
    coordinates = MapService.coordinates(location)
    Coordinates.new(coordinates)
  end
end
