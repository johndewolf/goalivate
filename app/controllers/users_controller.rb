class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @active_goals = @user.goals.active.order('end_date')
      .page(params[:active_goals_page])
    @past_goals = @user.goals.past.order('end_date desc')
      .page(params[:past_goals_page])
  end
end
