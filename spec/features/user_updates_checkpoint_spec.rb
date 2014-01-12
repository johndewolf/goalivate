require 'spec_helper'

feature 'user creates goal and updates checkpoint' do
  let(:goal) { FactoryGirl.create(:goal)}
  let!(:checkpoint) { FactoryGirl.create(:checkpoint, goal: goal) }

  scenario 'user enters in valid attributes for checkpoint' do
    sign_in_as(goal.user)
    click_on 'My Goals'
    click_on 'Go to goal'
    click_on 'Update Checkpoint'
    fill_in 'User input', with: goal.checkpoints.last.target
    click_on 'Update Checkpoint'
    Checkpoint.last.target.should be > Checkpoint.first.target
  end

  scenario 'user updates checkpoint that is one away from target' do
    ## this was added because there was an issue with next checkpoint never equaling the target
    sign_in_as(goal.user)
    click_on 'My Goals'
    click_on 'Go to goal'
    click_on 'Update Checkpoint'
    fill_in 'User input', with: goal.target_max - 1
    click_on 'Update Checkpoint'
    expect(Checkpoint.last.target).to eql(goal.target_max)
  end

  scenario 'user updates checkpoints multiple times' do
    sign_in_as(goal.user)
    click_on 'My Goals'
    click_on 'Go to goal'
    10.times do
      click_on 'Update Checkpoint'
      fill_in 'User input', with: goal.checkpoints.last.target - 1
      click_on 'Update Checkpoint'
    end
    expect(Checkpoint.all.count).to eql(11)
    end

  scenario 'user hit goal target' do
    sign_in_as(goal.user)
    click_on 'My Goals'
    click_on 'Go to goal'
    click_on 'Update Checkpoint'
    fill_in 'User input', with: goal.target_max
    click_on 'Update Checkpoint'
    expect(page).to_not have_content('Update Checkpoint')
  end

  scenario 'goal date is in the past' do
    goal = FactoryGirl.build(:goal, end_date: Date.yesterday - 1)
    goal.save(validate: false)
    FactoryGirl.create(:checkpoint, goal: goal)
    sign_in_as(goal.user)
    click_on 'My Goals'
    click_on 'Go to goal'
    expect(page).to_not have_content('Update Checkpoint')
  end
end
