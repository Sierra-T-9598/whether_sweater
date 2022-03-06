class Api::V1::BackgroundsController < ApplicationController
  def index
    location = params[:location]
    render json: ImageSerializer.new(ImageFacade.get_background_image(location))
  end
end
