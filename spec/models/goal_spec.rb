require 'spec_helper'

describe Goal do
  it { should have_valid(:target).when(200) }
  it { should_not have_valid(:target).when(nil) }

  it { should have_valid(:starting_point).when(100) }
  it { should_not have_valid(:starting_point).when(nil, -1) }

  it { should have_valid(:end_date).when(Date.today + 8) }
  it { should_not have_valid(:end_date).when(nil) }

  it { should have_valid(:title).when('Free throws') }
  it { should_not have_valid(:title).when('', nil) }

  it { should have_valid(:description).when('I want to shoot 1000 free throws in a month') }

  it { should have_valid(:unit_of_measurement).when('pushups', 'shots') }
  it { should_not have_valid(:unit_of_measurement).when('', nil) }

  it { should belong_to(:user) }

  it { should have_many(:checkpoints) }

  let(:goal) { FactoryGirl.create(:goal) }

  describe "#remaining_units" do
    let(:goal) { FactoryGirl.create(:goal, target: 100) }
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
        goal = FactoryGirl.create(:goal, target: 30)
        checkpoint1 = FactoryGirl.create(:checkpoint, goal: goal)
        checkpoint2 = FactoryGirl.create(:checkpoint, goal: goal, user_input: 12)
        goal.delete_invalid_checkpoints
        expect(goal.checkpoints.count).to eql(1)
      end
    end
  end

  describe "#active_goals" do
    context "the end date is in the future" do
      it "returns true" do
        goal = FactoryGirl.create(:goal)
        expect(Goal.active.first).to eql(goal)
      end

    end
    context "the end date is in the past" do
      it "does not return the goal" do
        goal = FactoryGirl.build(:goal, completed_on: Date.yesterday)
        goal.save(validate: false)
        expect(Goal.active.first).to eql(nil)
      end
    end
    context "user hit the target"
  end

  describe "#completed" do
    it "returns goals that have been completed" do
      goal = FactoryGirl.create(:goal, completed_on: Date.today)
      expect(Goal.completed.first).to eql(goal)
    end

    it "does not return goals that are not completed" do
      FactoryGirl.create(:goal)
      expect(Goal.completed.first).to eql(nil)
    end
  end

  describe "#incomple" do
    it "returns incomplete goals" do
      FactoryGirl.create(:goal)
      expect(Goal.incomplete.count).to eql(1)
    end
  end

  describe 'end_date_has_passed?' do
    it 'returns true if the end date of the goal is in the past' do
      goal = FactoryGirl.build(:goal, end_date: Date.today - 2.weeks)
      expect(goal.end_date_has_passed?).to eql true
    end
  end

end
