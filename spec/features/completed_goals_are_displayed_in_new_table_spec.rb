require 'spec_helper'

  feature 'user views goals', %Q{
    As an authenticated user
    I want to view my goals
    So that I can see what I have complete and
      what I am working on
  } do

    scenario 'user views past and current goals in two tables' do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:goal, user: user)
      past_goal = FactoryGirl.build(:goal, end_date: Date.yesterday, user: user)
      past_goal.save(validate: false)
      sign_in_as(user)
      visit "/users/#{user.id}"
      expect(page).to have_content('Active Goals')
      expect(page).to have_content('Past Goals')
    end

    scenario 'user has no past goal, past goal table is not displayed' do
      user = FactoryGirl.create(:user)
      goal = FactoryGirl.create(:goal, user: user)
      sign_in_as(user)
      visit "/users/#{user.id}"
      expect(page).to_not have_content('Past Goals')
    end
end
