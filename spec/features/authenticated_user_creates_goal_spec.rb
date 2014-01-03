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
      select '2014', from: 'Goal date'
      click_button 'Create Goal'
  end


    scenario 'user enters in goal weight lower than starting strength'
    scenario 'user enters goal date in the past or less than one week'
    scenario ''
end