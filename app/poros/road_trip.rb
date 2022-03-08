class RoadTrip
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(origin, destination, directions_data, weather_data)
    @start_city = origin
    @end_city = destination
    @travel_time = if_possible_route(directions_data)
    @weather_at_eta = find_weather_at_eta(directions_data, weather_data)
  end

  def if_possible_route(directions_data)
     if directions_data[:route][:routeError][:errorCode] == 2
       'Impossible'
     else
       directions_data[:route][:formattedTime]
     end
  end

  def find_weather_at_eta(directions_data, weather_data)
    if directions_data[:route][:routeError][:errorCode] == 2
      {}
    else
      index = (directions_data[:route][:formattedTime].to_i.round) - 1
      { temperature: weather_data.hourly_weather_full[index][:temperature],
        conditions: weather_data.hourly_weather_full[index][:conditions] }
    end
  end
end
