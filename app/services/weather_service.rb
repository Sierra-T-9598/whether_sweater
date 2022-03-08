class WeatherService
  def self.forecast_data(lat, lng, units = 'imperial')
    Rails.cache.fetch('forecast_data', expires_in: 1.hour) do
      get_data("2.5/onecall?lat=#{lat}&lon=#{lng}&exclude=minutely,alerts&units=#{units}")
    end
  end

  private

  def self.conn
    Faraday.new('https://api.openweathermap.org/data/') do |faraday|
        faraday.params['appid'] = ENV['weather_api_key']
      end
  end

  def self.get_data(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
