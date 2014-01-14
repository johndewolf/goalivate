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

  describe ".delete invalid checkpoints" do
    context "there are extra checkpoints due to user hitting the back button in browser" do
      it 'returns the correct amount of checkpoints' do
        goal = FactoryGirl.create(:goal, target_max: 30)
        checkpoint1 = FactoryGirl.create(:checkpoint, goal: goal)
        checkpoint2 = FactoryGirl.create(:checkpoint, goal: goal, user_input: 12)
        goal.delete_invalid_checkpoints
        expect(goal.checkpoints.count).to eql(1)
      end
    end
  end

  describe "#completed" do
    context "it returns true or false if the goal is completed" do
      it "returns false if the goal is not completed" do
        goal = FactoryGirl.create(:goal)
        expect(goal.completed?).to eql(false)
      end
    end

    context "it returns true or false if the goal is completed" do
      it "returns true if the user input for checkpoint is eql to goal target" do
        goal = FactoryGirl.create(:goal)
        FactoryGirl.create(:checkpoint, goal: goal, user_input: goal.target_max)
        FactoryGirl.create(:checkpoint, goal: goal)
        expect(goal.completed?).to eql(true)
      end
    end
  end

  describe "#active_goals" do
    context "there are goals with the end date in the future and
    user has not hit the target" do
      it "returns true" do
        goal = FactoryGirl.create(:goal)
        expect(goal.active_goal).to eql(true)
      end

    end
    context "there are goals in the past" do
      it "returns false" do
        goal = FactoryGirl.build(:goal, end_date: Date.yesterday)
        goal.save(validate: false)
        expect(goal.active_goal).to eql(false)
      end
    end
    context "user hit the target"
  end


  #   context 'it does not return inactive goals' do
  #   goal2 = FactoryGirl.build(:goal, end_date: Date.yesterday )
  #   goal3 = FactoryGirl.create(:goal)
  #   checkpoint = FactoryGirl.create(:checkpoint, target: goal3.target_max)
  #   goal2.save(validate: false)
  # end
end
