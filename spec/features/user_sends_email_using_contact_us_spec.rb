require 'spec_helper'

feature 'user sends email to Goalivate', %Q{
  As a site visitor
  I want to contact the site's staff
  So that I can ask questions or make comments about the site
} do
    # Acceptance Criteria:

    # I must specify a valid email address
    # I must specify a subject
    # I must specify a description
    # I must specify a first name
    # I must specify a last name
  scenario 'user sends email' do
    ActionMailer::Base.deliveries = []
    prev_count = ContactInquiry.count
    visit 'contact_inquiries/new'
    fill_in 'Email', with: 'jdewolf06@gmail.com'
    fill_in 'Subject', with: 'test'
    fill_in 'Content', with: 'testing the test'
    fill_in 'First name', with: 'Jack'
    fill_in 'Last name', with: 'DeWolf'
    click_button 'Submit Email'
    expect(page).to have_content('Email successfully sent')
    expect(ContactInquiry.count).to eql(prev_count + 1)

    expect(ActionMailer::Base.deliveries.size).to eql(1)
    last_email = ActionMailer::Base.deliveries.last
    expect(last_email).to have_subject('test')
    expect(last_email).to deliver_to('jdewolf06@gmail.com')
    expect(last_email).to have_body_text("testing the test")
  end
end
