class Checkpoint < ActiveRecord::Base
  validates_presence_of :goal_id
  validates_presence_of :target_weight

  belongs_to :goal,
    inverse_of: :checkpoints

end
