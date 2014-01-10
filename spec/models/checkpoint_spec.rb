require 'spec_helper'

describe Checkpoint do
  let(:checkpoint){ FactoryGirl.create(:goal).checkpoints.last }

  it { should belong_to(:goal) }

  it { should have_valid(:target).when(200) }
  it { should_not have_valid(:target).when(nil) }

  it { should have_valid(:goal).when(FactoryGirl.create(:goal)) }
  it { should_not have_valid(:goal).when(nil) }

  it { should have_valid(:complete_by).when(Date.today + 7) }
  it { should_not have_valid(:complete_by).when(nil, '') }

  it { should have_valid(:user_input).when(200) }

  it 'calculates days remaining' do
    expect(checkpoint.days_remaining).to eql((checkpoint.goal.end_date - checkpoint.updated_at) / 86400)
  end

  it 'updates the complete_by to the end date if the checkpoint is updated
    with less than 7 days remaining to the end of the goal' do
    checkpoint.updated_at = checkpoint.goal.end_date - 2
    checkpoint.save
    checkpoint.complete_by = checkpoint.calculate_complete_by
    checkpoint.save
    expect(checkpoint.complete_by).to eql(checkpoint.goal.end_date)
  end

  it 'increases the target reps and creates new checkpoint on update' do
    checkpoint.user_input = checkpoint.target + 2
    checkpoint.save
    expect(Checkpoint.last.target).should be > (Checkpoint.first.target)
  end
end
