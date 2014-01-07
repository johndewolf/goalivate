require 'spec_helper'

feature 'user creates a goal', %Q{
  As an autheticated user
  I want to create a goal
  So that I can track my progress
} do
  given(:user) { FactoryGirl.create(:user) }

    scenario 'user enters in valid input and saves' do
      FactoryGirl.create(:exercise)
      sign_in_as(user)
      click_button 'Create a Goal'
      select 'bench press', from: 'Exercise'
      fill_in 'Starting strength', with: 200
      fill_in 'Goal weight', with: 210
      select Date.today.year + 1, from: 'Goal date'
      click_button 'Create Goal'
      expect(page).to have_content('Goal successfully created')
  end


    scenario 'user enters in goal weight lower than starting strength' do
      FactoryGirl.create(:exercise)
      sign_in_as(user)
      click_button 'Create a Goal'
      select 'bench press', from: 'Exercise'
      fill_in 'Starting strength', with: 220
      fill_in 'Goal weight', with: 210
      select Date.today.year + 1, from: 'Goal date'
      click_button 'Create Goal'
      expect(page).to have_content('Goal Weight must be greater than starting strength')
  end
    scenario 'user enters goal date in the past or less than one week'
    scenario ''
end
