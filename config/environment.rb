# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
BreakableToyTwo::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => 'app21279338@heroku.com',
  :password => 'msfy6k8l',
  :domain => 'http://goalivate.herokuapp.com/',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
