class Checkpoint < ActiveRecord::Base
  validates_presence_of :goal
  validates_presence_of :target
  validates :user_input, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  validates_presence_of :complete_by

  belongs_to :goal,
    inverse_of: :checkpoints

  def self.next_for(goal)
    if Checkpoint.last.user_input >= goal.target_max
      goal.completed_on = Date.today
    else
      goal.delete_invalid_checkpoints
      goal.checkpoints.create(
        target: unit_increase(goal),
        complete_by: calculate_complete_by(goal)
      )
    end
  end

  def self.completed
    where("user_input IS NOT null")
  end

  # def days_remaining
  #   (goal.end_date - goal.checkpoints.last.updated_at) / (24 * 60 * 60)
  # end

  #   def rep_increase
  #   increase = ((goal.target_max - goal.checkpoints.last.user_input) / checkpoints_remaining)
  #   increase += 1 if increase == 0
  #   next_target = goal.checkpoints.last.user_input + increase
  #   if next_target == goal.target_max - 1
  #     goal.target_max
  #   else
  #     next_target
  #   end
  # end

  def self.unit_increase(goal)
    increase = ((goal.target_max - last_input_or_starting_max(goal)) / checkpoints_remaining(goal))
    increase += 1 if increase == 0
    next_target = last_input_or_starting_max(goal) + increase
    if next_target == goal.target_max - 1
      goal.target_max
    else
      next_target
    end
  end

  def self.last_input_or_starting_max(goal)
    if goal.checkpoints.completed.any?
      if goal.checkpoints.last.user_input != nil
        goal.checkpoints.last.user_input
      else
        where("user_input IS NOT null").last.user_input
      end
    else
      goal.starting_max
    end
  end

  def self.calculate_complete_by(goal)
    goal.days_remaining < 7 ? goal.end_date : Date.today + 7
  end

  def self.checkpoints_remaining(goal)
    (goal.days_remaining / 7.0).ceil
  end
end
