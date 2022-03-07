class Forecast
  attr_reader :id, :current_weather, :daily_weather, :hourly_weather

  def initialize(data)
    @id = nil
    @current_weather = current(data[:current])
    @hourly_weather = hourly(data[:hourly]).take(8)
    @daily_weather = daily(data[:daily]).take(5)
  end

  def current(data)
    { date_time: Time.at(data[:dt]).strftime("%I:%M %p, %B %d, %z"),
      sunrise: Time.at(data[:sunrise]).strftime("%I:%M %p, %B %d, %z"),
      sunset: Time.at(data[:sunset]).strftime("%I:%M %p, %B %d, %z"),
      temperature: data[:temp],
      feels_like: data[:feels_like],
      humidity: data[:humidity],
      uvi: data[:uvi],
      visibility: data[:visibility],
      conditions: data[:weather][0][:description],
      icon: data[:weather][0][:icon]
    }
  end

  def hourly(data)
    data.map do |hour|
      { time: Time.at(hour[:dt]).strftime("%I:%M %p"),
        temperature: hour[:temp],
        conditions: hour[:weather][0][:description],
        icon: hour[:weather][0][:icon],
      }
    end
  end

  def daily(data)
    data.map do |day|
      { date: Time.at(day[:dt]).strftime("%d-%m-%Y"),
        sunrise: Time.at(day[:sunrise]).strftime("%I:%M %p, %B %d, %z"),
        sunset: Time.at(day[:sunset]).strftime("%I:%M %p, %B %d, %z"),
        max_temp: day[:temp][:max],
        min_temp: day[:temp][:min],
        conditions: day[:weather][0][:description],
        icon: day[:weather][0][:icon],
      }
    end
  end

  def forecast_lite
    {
      summary: @current_weather[:conditions],
      temperature: @current_weather[:temperature].to_s + "F"
    }
  end
end
