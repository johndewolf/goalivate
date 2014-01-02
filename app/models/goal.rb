class Goal < ActiveRecord::Base
  validates_presence_of :goal_weight
  validates_presence_of :goal_date
  validates_presence_of :exercise_id

  belongs_to :user,
    inverse_of: :goals

  belongs_to :exercise,
    inverse_of: :goals

  has_many :checkpoints,
    inverse_of: :goal
end
