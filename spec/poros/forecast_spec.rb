require 'rails_helper'

RSpec.describe Forecast do
  it 'exits' do
    data = { current: {dt: 1646519674, sunrise: 1646488531, sunset: 1646529365, temp: 25.48, feels_like: 21.96, humidity: 71, uvi: 0.72, visibility: 10000, weather: [{description: "broken clouds", icon: "04d"}]},
            hourly: [{dt: 1646517600, temp: 25.86, weather: [{description: "broken clouds", icon: "04d"}]}],
            daily: [{dt: 1646506800, sunrise: 1646488531, sunset: 1646529365, temp: {min: 18.28, max: 26.53}, weather: [{description: "snow", icon: "13d"}]}]
          }
    forecast = Forecast.new(data)

    expect(forecast.current_weather).to be_a Hash
    expect(forecast.hourly_weather).to be_an Array
    expect(forecast.hourly_weather.length).to eq(1)
    expect(forecast.daily_weather).to be_an Array
    expect(forecast.daily_weather.length).to eq(1)
    # if test data for hourly weather had more than 8 elements,
    #this method would return all hourly weather data for the location
    expect(forecast.hourly_weather_full.length).to eq(1)
  end
end
