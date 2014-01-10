require 'spec_helper'

describe Goal do
  it { should have_valid(:target_max).when(200) }
  it { should_not have_valid(:target_max).when(nil) }

  it { should have_valid(:starting_max).when(100) }
  it { should_not have_valid(:starting_max).when(nil) }

  it { should have_valid(:end_date).when(Date.today + 8) }
  it { should_not have_valid(:end_date).when(nil) }

  it { should have_valid(:exercise).when(FactoryGirl.create(:exercise)) }
  it { should_not have_valid(:exercise).when(nil) }

  it { should belong_to(:user) }

  it { should have_many(:checkpoints) }

  it 'returns false if the end date is in the future' do
    goal = FactoryGirl.create(:goal)
    expect(goal.end_date_has_passed?).to eql(false)
  end
end
