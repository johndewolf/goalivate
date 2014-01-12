require 'spec_helper'

describe Goal do
  let(:goal) { FactoryGirl.create(:goal) }
  it { should have_valid(:target_max).when(200) }
  it { should_not have_valid(:target_max).when(nil) }

  it { should have_valid(:starting_max).when(100) }
  it { should_not have_valid(:starting_max).when(nil, -1) }

  it { should have_valid(:end_date).when(Date.today + 8) }
  it { should_not have_valid(:end_date).when(nil) }

  it { should have_valid(:exercise).when(FactoryGirl.create(:exercise)) }
  it { should_not have_valid(:exercise).when(nil) }

  it { should belong_to(:user) }

  it { should have_many(:checkpoints) }

  it 'returns false if the end date is in the future' do
    expect(goal.end_date_has_passed?).to eql(false)
  end

  it 'returns true if the user input equals the goal target' do
    goal = FactoryGirl.create(:goal, target_max: 25)
    FactoryGirl.create(:checkpoint, goal: goal, user_input: goal.target_max)
    FactoryGirl.create(:checkpoint, goal: goal, user_input: nil)
    expect(goal.completed?).to eql(true)
  end

  describe "#remaining_units" do
    let(:goal) { FactoryGirl.create(:goal, target_max: 100) }
    context "no checkpoints have been completed" do
      it "returns the amount of remaining units" do
        expect(goal.remaining_units).to eq 100
      end
    end

    context "when one checkpoint has been completed" do
      let!(:checkpoint) { FactoryGirl.create(:completed_checkpoint, goal: goal, user_input: 30) }

      it "returns the amount of remaining units" do
        expect(goal.remaining_units).to eq 70
      end
    end

    context "when multiple checkpoints have been completed" do
      let!(:checkpoint1) { FactoryGirl.create(:completed_checkpoint, goal: goal, user_input: 30) }
      let!(:checkpoint2) { FactoryGirl.create(:completed_checkpoint, goal: goal, user_input: 50) }

      it "returns the amount of remaining units" do
        expect(goal.remaining_units).to eq 50
      end
    end
  end

  describe "#days_remaining" do
    let!(:goal) { FactoryGirl.create(:goal, end_date: Date.today + 9.days) }
    it 'calculates days remaining' do
      expect(goal.days_remaining).to eql(9)
    end
  end
end
