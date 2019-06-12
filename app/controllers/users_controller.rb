require_relative 'application_controller'

class UsersController < ApplicationController

  before_action :fetch_user!, only: [:unsubscribe, :destroy]

  def new
    @user = User.new
    neighbours

    render layout: 'themeless'
  end

  def create
    @user = User.new user_params
    if @user.valid?
      @user.save
      NotificationWorker.perform_async({'user_id' => @user.id})
    else
      neighbours
    end

    render layout: 'themeless'
  end

  def unsubscribe
    render layout: 'themeless'
  end

  def destroy
    @user.destroy
    render layout: 'themeless'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :neighbours_id)
  end

  def neighbours
    @neighbours ||= Neighbour.order(:name).all
  end

  def fetch_user!
    @user = User.find_by_id(params[:user_id] || params[:id])
    redirect_to root_path unless @user.present?
  end
end