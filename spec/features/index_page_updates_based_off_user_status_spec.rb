require 'spec_helper'

feature 'index page is dependent on if current user is logged in' do

  scenario 'user is not logged in' do
    visit root_path
    expect(page).to have_content('Sign Up')
  end

  scenario 'user is logged in but does not have active goal' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit root_path
    expect(page).to have_content('You have no goals')
  end

  scenario 'user is logged in but and has active goal' do
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:goal, user: user)
    sign_in_as(user)
    visit root_path
    expect(page).to have_content('Your active goals')
  end
end
