require 'spec_helper'

feature 'user sign up', %Q{
  As an unautheticated user
  I want to sign up
  So that I can use JackFit
} do
  scenario 'with valid and required attributes' do
    visit root_path
    click_link "Sign Up"
    fill_in 'First name', with: 'test'
    fill_in 'Last name', with: 'test'
    fill_in 'Email', with: 'test@aol.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content("Welcome! You have signed up successfully" )
  end

  scenario 'with missing required attributes' do
      visit root_path
      click_link "Sign Up"
      click_button 'Sign up'
      expect(page).to have_content("First name can't be blank")
      expect(page).to have_content("Last name can't be blank")
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")

  end

  scenario 'with password confirmation not matching' do
    visit root_path
    click_link "Sign Up"
    fill_in 'First name', with: 'test'
    fill_in 'Last name', with: 'test'
    fill_in 'Email', with: 'test@aol.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'passowrd'
    click_button 'Sign up'
    expect(page).to have_content("Password confirmation doesn't match")
  end
end
