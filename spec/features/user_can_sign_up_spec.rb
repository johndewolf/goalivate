require 'spec_helper'

feature 'user sign up', %Q{
  As an unautheticated user
  I want to sign up
  So that I can use JackFit
} do
  scenario 'with valid and required attributes' do
    visit root_path
    click_link "Sign Up"
    fill_in 'Email', with: 'test@aol.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'
    expect(page).to have_content('Welcome to JackFit!')
  end

  scenario 'with missing required attributes'
  scenario 'with password confirmation not matching'
end
