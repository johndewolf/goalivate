class Goal < ActiveRecord::Base
  validates_presence_of :exercise
  validates_presence_of :starting_strength
  validates_presence_of :goal_weight
  validates_presence_of :goal_date
  validate :date_is_in_the_future,
    if: -> (goal) { goal.goal_date.present? }
  validate :goal_is_greater_than_start,
    if: -> (goal) { goal.goal_weight.present? && goal.starting_strength.present? }
  belongs_to :user,
  inverse_of: :goals

  belongs_to :exercise,
  inverse_of: :goals

  has_many :checkpoints,
  inverse_of: :goal


  def goal_is_greater_than_start
    unless goal_weight > starting_strength
      errors[:goal_weight] << 'Goal Weight must be greater than starting strength'
    end
  end

  def date_is_in_the_future
    unless goal_date > Date.today + 7
      errors[:goal_date] << "must be 7 days in the future"
    end
  end

end

