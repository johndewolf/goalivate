class CheckpointsController < ApplicationController
before_filter :check_session

  def show
    @checkpoint = Checkpoint.find(params[:id])
  end

  def edit
    @checkpoint = current_user.checkpoints.find(params[:id])
    @goal = @checkpoint.goal
  end

  def update
    @checkpoint = current_user.checkpoints.find(params[:id])
      if @checkpoint.update(checkpoint_params)
        Checkpoint.next_for(@checkpoint.goal)
        redirect_to @checkpoint.goal, notice: 'Goal was successfully updated.'
      else
        render action: 'edit'
      end
  end

  def index
  end

  protected
  def checkpoint_params
    params.require(:checkpoint).permit(:target, :user_input,
      :goal_id)
  end
end
