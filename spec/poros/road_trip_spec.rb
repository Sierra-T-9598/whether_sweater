require 'rails_helper'

RSpec.describe RoadTrip do
  it 'exists' do
    origin = "bozeman,MT"
    destination = "lyons,CO"
    directions_data = { route: {
          routeError: { errorCode: -400, message: ""},
          formattedTime: "05:48:43" } }

    data = { current: {dt: 1646519674, sunrise: 1646488531, sunset: 1646529365, temp: 25.48, feels_like: 21.96, humidity: 71, uvi: 0.72, visibility: 10000, weather: [{description: "broken clouds", icon: "04d"}]},
            hourly: [{dt: 1646517600, temp: 25.86, weather: [{description: "broken clouds", icon: "04d"}]}, {dt: 1646517600, temp: 25.86, weather: [{description: "broken clouds", icon: "04d"}]}, {dt: 1646517600, temp: 25.86, weather: [{description: "broken clouds", icon: "04d"}]}, {dt: 1646517600, temp: 25.86, weather: [{description: "broken clouds", icon: "04d"}]},
            {dt: 1646517600, temp: 25.86, weather: [{description: "this is the one we're looking for", icon: "04d"}]}, {dt: 1646517600, temp: 25.86, weather: [{description: "broken clouds", icon: "04d"}]}, {dt: 1646517600, temp: 25.86, weather: [{description: "broken clouds", icon: "04d"}]}, {dt: 1646517600, temp: 25.86, weather: [{description: "broken clouds", icon: "04d"}]}],
            daily: [{dt: 1646506800, sunrise: 1646488531, sunset: 1646529365, temp: {min: 18.28, max: 26.53}, weather: [{description: "snow", icon: "13d"}]}]
            }
    weather_data = Forecast.new(data)

    road_trip = RoadTrip.new(origin, destination, directions_data, weather_data)

    expect(road_trip.start_city).to eq(origin)
    expect(road_trip.end_city).to eq(destination)
    expect(road_trip.travel_time).to eq("05:48:43")
    # Checking that everything can run through the #find_weather_at_eta method,
    # though this is not an accurate reflection of actual data
    expect(road_trip.weather_at_eta).to be_a Hash
    expect(road_trip.weather_at_eta[:conditions]).to eq("this is the one we're looking for")
  end
end
