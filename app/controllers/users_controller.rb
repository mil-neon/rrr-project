class UsersController < ApplicationController
  def index
    @userdata = User.all
    @user = User.new
  end

  def create
    @user = User.create(user_params)
  end

  private
  def user_params
    params.require(:user).permit(:name,:birthday)
  end
end
