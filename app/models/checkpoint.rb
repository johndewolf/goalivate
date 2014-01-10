class Checkpoint < ActiveRecord::Base
  after_update :create_next_checkpoint

  validates_presence_of :goal
  validates_presence_of :target
  validates_presence_of :complete_by

  belongs_to :goal,
    inverse_of: :checkpoints

  def create_next_checkpoint
    if goal_met? != true
      Checkpoint.create(target: rep_increase, goal: goal, complete_by: calculate_complete)
    end
  end

  def days_remaining
    (goal.end_date - goal.checkpoints.last.updated_at) / (24 * 60 * 60)
  end

  def rep_increase
    increase = ((goal.target_max - goal.checkpoints.last.user_input) / checkpoints_remaining)
    if increase == 0
      increase = increase + 1
    end
    next_target = goal.checkpoints.last.user_input + increase
    if next_target == goal.target_max - 1
      goal.target_max
    else
      next_target
    end
  end

  def calculate_complete
    if days_remaining < 7
      goal.end_date
    else
      Date.today + 7
    end
  end

  def checkpoints_remaining
    (days_remaining / 7.0).ceil
  end

  def goal_met?
    true if goal.checkpoints.last.user_input == goal.target_max
  end
end
