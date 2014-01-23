require 'spec_helper'

feature 'weekly updates are sent to users', %Q{
    As the site admin,
    I want weekly summaries sent to the users
    So they can stay updated on their checkpoints
} do
  scenario 'user receives an email' do
    ActionMailer::Base.deliveries = []
    FactoryGirl.create(:user)
    AllUsersWorker.perform_async
    expect(ActionMailer::Base.deliveries.size).to eql(1)
    last_email = ActionMailer::Base.deliveries.last
    expect(last_email).to deliver_to(user.email)
  end
end
