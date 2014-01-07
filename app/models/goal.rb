class Goal < ActiveRecord::Base
  validates_presence_of :exercise_id
  validates_presence_of :starting_strength
  validate :date_is_in_the_future
  validate :goal_is_greater_than_start
  belongs_to :user,
  inverse_of: :goals

  belongs_to :exercise,
  inverse_of: :goals

  has_many :checkpoints,
  inverse_of: :goal


  def goal_is_greater_than_start
    unless starting_strength < goal_weight
      errors[:goal_weight] << 'Goal Weight must be greater than starting strength'
    end
  end

  def date_is_in_the_future
    unless goal_date > Date.today + 7
      errors[:goal_date] << "must be 7 days in the future"
    end
  end

end

