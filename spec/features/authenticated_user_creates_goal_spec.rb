require 'spec_helper'

feature 'user creates a goal', %Q{
  As an autheticated user
  I want to create a goal
  So that I can track my progress
} do
  let(:user) { FactoryGirl.create(:user) }

  scenario 'user enters in valid input and saves' do
    sign_in_as(user)
    click_on 'You have no goals! Create one!'
    fill_in 'Title', with: 'pushups'
    fill_in 'Starting point', with: 50
    fill_in 'Unit of measurement', with: 'pushup'
    fill_in 'Target', with: 100
    select Date.today.year + 1, from: 'Goal date'
    click_on 'Create Goal'
    expect(page).to have_content('Goal successfully created')
  end

  scenario 'user enters in goal weight lower than starting strength' do
    sign_in_as(user)
    click_on 'You have no goals! Create one!'
    fill_in 'Starting point', with: 50
    fill_in 'Unit of measurement', with: 'pushup'
    fill_in 'Target', with: 40
    select Date.today.year + 1, from: 'Goal date'
    click_on 'Create Goal'
    expect(page).to have_content('Goal max must be greater than starting')
  end

  scenario 'user enters goal date in the past or less than one week' do
    sign_in_as(user)
    click_on 'You have no goals! Create one!'
    fill_in 'Starting point', with: 50
    fill_in 'Unit of measurement', with: 'pushup'
    fill_in 'Target', with: 40
    click_on 'Create Goal'
    expect(page).to have_content('must be 7 days in the future')
  end

end
