class UsersController < ApplicationController
  def index
    @userdata = User.all
    @userinput = User.new
  end
end
