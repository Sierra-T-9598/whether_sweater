class Api::V1::ForecastsController < ApplicationController
  def index
    if !params[:location] || params[:location] == ""
      render json: { error: "Missing location." }, status: 400
    else
      location = params[:location]
      forecast = ForecastFacade.get_forecast(location)
      render json: ForecastSerializer.new(forecast)
    end
  end
end
