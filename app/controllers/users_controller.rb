class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @active_goals = @user.goals.active.paginate(:page => params[:active_goals],
      per_page: 10).order('end_date')
    @past_goals = @user.goals.past.paginate(:page => params[:past_goals],
      per_page: 10).order('end_date')
  end
end
