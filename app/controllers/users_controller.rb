class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = current_user
    @goals = Exercise.all.map do |exercise|
      Goal.new(exercise: exercise)
    end
  end

end
