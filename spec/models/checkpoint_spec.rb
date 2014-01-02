require 'spec_helper'

describe Checkpoint do
  it { should belong_to(:goal) }

  it { should have_valid(:target_weight).when(200) }
  it { should_not have_valid(:target_weight).when(nil) }

  it { should have_valid(:goal_id).when(1) }
  it { should_not have_valid(:goal_id).when(nil) }

  it { should have_valid(:weight_lifted).when(200) }
end
