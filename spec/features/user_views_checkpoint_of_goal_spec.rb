require 'spec_helper'

feature 'user views checkpoints', %Q{
  As an autheticated user
  I want to view my next checkpoint
  So that I can I know what my goal is to hit
} do

  given(:user) { FactoryGirl.create(:user) }
  given(:goal) { FactoryGirl.create(:goal) }

  scenario 'user navigates to checkpoint page' do
    sign_in_as(user)
    checkpoint = goal.checkpoints.first
    visit goal_checkpoint_path(goal.id, checkpoint.id)
    expect(page).to have_content(goal.checkpoints.first.target)
  end
end
