# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  # GET /api/v1/users
  def index
    @users = User.all
    render json: @users
  end

  # POST /api/v1/users
  def create
    if User.exists?(user_params)
      @user = User.new
      @user.generate_new_pseudo
      message = "The #{user_params[:pseudo]} already exist but your registration was completed with auto generated pseudo #{@user[:pseudo]}. Do you want to modify it ?"
    else
      @user = User.new(user_params)

      return render json: { message: "Bad format of pseudo" }, status: :unprocessable_entity unless @user.valid?

      @user.generate_decimal_index
      message = "your registration with pseudo #{user_params[:pseudo]} is now complete"
    end

    if @user.save
      render json: { message: message }, status: :created
    else
      render json: { message: "Bad format of pseudo" }, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def user_params
    params.fetch(:user).permit([:pseudo])
  end
end
