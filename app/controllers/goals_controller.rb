class GoalsController < ApplicationController
  def index
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.create(goal_params)

    if @goal.save
      Checkpoint.next_for(@goal)
      redirect_to user_path(current_user),
        notice: "Goal successfully created"
    else
      render :new
    end
  end

  def delete
    @user = current_user
    @goal = current_user.goals.find(params[:id])
  end

  def show
    @goal = Goal.find(params[:id])
    @user = current_user
  end

  def edit
    @goal = current_user.goals.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
      if @goal.update(goal_params)
        redirect_to @goal, notice: 'Goal was successfully updated.'
      else
        render action: 'edit'
      end
  end

  def destroy
    @goal = Goal.find(params[:id])
    if @goal.destroy
      redirect_to user_path(current_user), notice: 'Goal was deleted'
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:starting_max, :target_max,
      :end_date, :exercise_id, :user)
  end
end
