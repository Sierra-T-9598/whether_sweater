class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user] = user.id
      render json: UsersSerializer.new(user), status: 200
    else
      render json: { error: "Email and/or password is incorrect"}, status: 400
    end
  end
end
