class Goal < ActiveRecord::Base
  validates_presence_of :goal_date
  validates_presence_of :exercise_id
  validates_presence_of :starting_strength
  validate :goal_weight, reject_if: lambda { |a| a[:starting_strength] < a[:goal_weight] }

  belongs_to :user,
    inverse_of: :goals

  belongs_to :exercise,
    inverse_of: :goals

  has_many :checkpoints,
    inverse_of: :goal

  def strength_value_order
    if self.goal_weight && (self.starting_strength > self.goal_weight)
      self.errors.add_to_base("Goal Weight value must be greater than starting strength.")
    end
  end
end
