class CheckpointsController < ApplicationController

  def show
    @checkpoint = Checkpoint.find(params[:id])
  end

  def edit
    @checkpoint = Checkpoint.find(params[:id])
    @goal = @checkpoint.goal
  end

  def update
    @checkpoint = Checkpoint.find(params[:id])
      if @checkpoint.update(checkpoint_params)
        Checkpoint.next_for(@checkpoint.goal)
        AllUsersWorker.perform_async
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
