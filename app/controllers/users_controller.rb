class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @goals = @user.goals.last
  end

end
