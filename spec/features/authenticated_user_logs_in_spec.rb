require 'spec_helper'

feature 'user sign up', %Q{
  As an autheticated user
  I want to log in
  So that I can use JackFit
} do
  given(:user) { FactoryGirl.create(:user) }

  scenario 'with valid and required attributes' do
    visit root_path
    click_link "Sign In"
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    expect(page).to have_content('Welcome to JackFit')
  end
end
