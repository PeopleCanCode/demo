class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def index
    # @users = User.all - we will replace this old code, you can delete this line
    @users = User.page(params[:page]).per(30)
  end
end
