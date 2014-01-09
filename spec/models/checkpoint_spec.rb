require 'spec_helper'

describe Checkpoint do
  it { should belong_to(:goal) }

  it { should have_valid(:target).when(200) }
  it { should_not have_valid(:target).when(nil) }

  it { should have_valid(:goal).when(FactoryGirl.create(:goal)) }
  it { should_not have_valid(:goal).when(nil) }

  it { should have_valid(:user_input).when(200) }
end
