require 'spec_helper'

feature 'user creates a goal', %Q{
  As an autheticated user
  I want to create a goal
  So that I can track my progress
} do
  given(:user) { FactoryGirl.create(:user) }
  before(:each) { FactoryGirl.create(:exercise) }

  scenario 'user enters in valid input and saves' do
    sign_in_as(user)
    click_button 'Create a Goal'
    select 'squats', from: 'Exercise'
    fill_in 'Starting max', with: 200
    fill_in 'Target max', with: 210
    select Date.today.year + 1, from: 'Goal date'
    click_button 'Create Goal'
    expect(page).to have_content('Goal successfully created')
  end

  scenario 'user enters in goal weight lower than starting strength' do
    sign_in_as(user)
    click_button 'Create a Goal'
    select 'squats', from: 'Exercise'
    fill_in 'Starting max', with: 220
    fill_in 'Target max', with: 210
    select Date.today.year + 1, from: 'Goal date'
    click_button 'Create Goal'
    expect(page).to have_content('Goal max must be greater than starting')
  end

  scenario 'user enters goal date in the past or less than one week' do
    sign_in_as(user)
    click_button 'Create a Goal'
    select 'squats', from: 'Exercise'
    fill_in 'Starting max', with: 22
    fill_in 'Target max', with: 25
    click_button 'Create Goal'
    expect(page).to have_content('must be 7 days in the future')
  end

end
