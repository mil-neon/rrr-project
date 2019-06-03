class UsersController < ApplicationController
  def index
    @userdata = User.all
    @user = User.new
  end

  def create
    @user = User.create(article_params)
  end

  private
  def article_params
    params.require(:user).permit(:name,:birthday)
  end
end
