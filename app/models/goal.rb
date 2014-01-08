class Goal < ActiveRecord::Base
  validates_presence_of :exercise
  validates_presence_of :starting_max
  validates_presence_of :target_max
  validates_presence_of :end_date
  validate :date_is_in_the_future,
    if: -> (goal) { goal.end_date.present? }
  validate :goal_is_greater_than_start,
    if: -> (goal) { goal.target_max.present? && goal.starting_max.present? }
  belongs_to :user,
  inverse_of: :goals

  belongs_to :exercise,
  inverse_of: :goals

  has_many :checkpoints,
  inverse_of: :goal

  def create_checkpoints
    weeks_in_goal.times do
      Checkpoint.create(target: first_target, goal: self)
    end
  end

  def goal_is_greater_than_start
    unless target_max > starting_max
      errors[:target_max] << 'Goal max must be greater than starting '
    end
  end

  def date_is_in_the_future
    unless end_date > Date.today + 7
      errors[:end_date] << "must be 7 days in the future"
    end
  end

  def weeks_in_goal
    ((end_date - created_at) / (24 * 60 * 60)).to_i / 7
  end

  def first_target
    increase_percent = (target_max.to_f - starting_max) / target_max
    rep_increase = target_max * increase_percent
    (starting_max + rep_increase / weeks_in_goal).round
  end
end

