class Checkpoint < ActiveRecord::Base
  validates_presence_of :goal
  validates_presence_of :target

  belongs_to :goal,
    inverse_of: :checkpoints
end
