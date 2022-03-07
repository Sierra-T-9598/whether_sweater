class Api::V1::UsersController < ApplicationController
  # before_action :set_private_api_key

  def create
    user = User.new(user_params)

    if params[:password] != params[:password_confirmation] || !params[:password] && !params[:password_confirmation]
      render json: {error: "Passwords do not match or field is missing, please try again"}, status: 400
    elsif !params[:password] || !params[:email] || !params[:password_confirmation]
      render json: {error: "Missing field(s), please try again"}, status: 400
    else params[:password] == params[:password_confirmation] && params[:email] != nil
      validate_email(user)
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def validate_email(new_user)
    if new_user.save
      render json: UsersSerializer.new(new_user), status: 201
    else
      render json: {error: "Email has already been taken, please try again"}, status: 400
    end
  end

  # def set_private_api_key
  #   user.private_api_key = SecureRandom.urlsafe_base64(24)
  # end
end
