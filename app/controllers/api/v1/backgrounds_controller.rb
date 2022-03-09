class Api::V1::BackgroundsController < ApplicationController
  def index
    if !params[:location] || params[:location] == ""
      render json: { error: "Missing location." }, status: 400
    else
      location = params[:location]
      render json: ImageSerializer.new(ImageFacade.get_background_image(location))
    end
  end
end
