class Api::V1::RoadTripsController < ApplicationController
  def create
    user = User.find_by(private_api_key: params[:private_api_key])
    if !params[:origin] || !params[:destination]
      render json: { error: "You're missing a vital component for planning a road trip!"}, status: 400
    elsif user != nil
      road_trip = RoadTripFacade.get_road_trip(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(road_trip), status: 201
    else
      render json: { error: "You are not authorized"}, status: 401
    end
  end
end
