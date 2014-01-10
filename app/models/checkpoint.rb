class Checkpoint < ActiveRecord::Base
  after_update :create_next_checkpoint

  validates_presence_of :goal
  validates_presence_of :target
  validates :user_input, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  validates_presence_of :complete_by

  belongs_to :goal,
    inverse_of: :checkpoints

  def create_next_checkpoint
    if goal.goal_met? != true && goal.checkpoints.last.user_input != nil
      Checkpoint.create(target: rep_increase, goal: goal, complete_by: calculate_complete_by)
    end
  end

  def days_remaining
    (goal.end_date - goal.checkpoints.last.updated_at) / (24 * 60 * 60)
  end

  def rep_increase
    increase = ((goal.target_max - goal.checkpoints.last.user_input) / checkpoints_remaining)
    increase += 1 if increase == 0
    next_target = goal.checkpoints.last.user_input + increase
    if next_target == goal.target_max - 1
      goal.target_max
    else
      next_target
    end
  end

  def calculate_complete_by
    days_remaining < 7 ? goal.end_date : Date.today + 7
  end

  def checkpoints_remaining
    (days_remaining / 7.0).ceil
  end

end
