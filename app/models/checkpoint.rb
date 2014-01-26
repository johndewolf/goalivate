class Checkpoint < ActiveRecord::Base
  validates_presence_of :goal
  validates_presence_of :target
  validates :user_input, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  validates_presence_of :complete_by

  belongs_to :goal,
    inverse_of: :checkpoints

  def self.next_for(goal)
    goal.delete_invalid_checkpoints
    if goal.checkpoints.completed.any? &&
      goal.checkpoints.last.user_input >= goal.target
      goal.completed_on = Date.today
      goal.save
    else
      goal.checkpoints.create(
        target: unit_increase(goal),
        complete_by: calculate_complete_by(goal)
      )
    end
  end

  def self.completed
    where.not(user_input: nil)
  end

  def self.unit_increase(goal)
    increase = ((goal.target.to_f - last_input_or_starting_point(goal)) /
      remaining(goal))
    next_target = last_input_or_starting_point(goal) + increase
    if next_target == goal.target - 1
      goal.target
    else
      next_target
    end
  end

  def self.last_input_or_starting_point(goal)
    if goal.checkpoints.completed.any?
      if goal.checkpoints.last.user_input != nil
        goal.checkpoints.last.user_input
      else
        where("user_input IS NOT null").last.user_input
      end
    else
      goal.starting_point
    end
  end

  def self.calculate_complete_by(goal)
    goal.days_remaining < 7 ? goal.end_date : Date.today + 7
  end

  def self.remaining(goal)
    (goal.days_remaining / 7.0).ceil
  end
end
