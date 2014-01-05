require 'spec_helper'

describe Goal do
  it { should have_valid(:goal_weight).when(200) }
  it { should_not have_valid(:goal_weight).when(nil) }

  it { should have_valid(:goal_date).when(Date.today + 8) }
  it { should_not have_valid(:goal_date).when(nil) }

  it { should have_valid(:exercise_id).when(1) }
  it { should_not have_valid(:exercise_id).when(nil) }

  it { should belong_to(:user) }

  it { should have_many(:checkpoints) }
end
