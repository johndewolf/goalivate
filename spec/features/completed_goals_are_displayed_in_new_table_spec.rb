require 'spec_helper'

  feature 'user views goals', %Q{
    As an authenticated user
    I want to view my goals
    So that I can see what I have complete and
      what I am working on
  } do

    scenario 'user views past and current goals in two tables' do
      user = FactoryGirl.create(:user)
      sign_in_as(user)
      goal1 = FactoryGirl.create(:goal, user: user)
      checkpoint1 = FactoryGirl.create(:checkpoint, goal: goal1)
      goal2 = FactoryGirl.create(:goal, user: user)
      checkpoint2 = FactoryGirl.create(:checkpoint, goal: goal2, user_input: goal2.target_max)
      visit "/users/#{user.id}"
      expect(page).to have_content('Active Goals')
      expect(page).to have_content('Past Goals')
    end

    scenario 'user has no past goal, past goal table is not displayed' do
      user = FactoryGirl.create(:user)
      goal = FactoryGirl.create(:goal, user: user)
      sign_in_as(user)
      visit "/users/#{user.id}"
      save_and_open_page
      expect(page).to_not have_content('Past Goals')
    end
end
