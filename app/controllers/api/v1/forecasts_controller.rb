class Api::V1::ForecastsController < ApplicationController
  def index
    location = params[:location]
    forecast = ForecastFacade.get_forecast(location)
    render json: ForecastSerializer.new(forecast)
  end
end
