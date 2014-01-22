class GoalSummaryMailer < ActionMailer::Base

  def send_summary(user)
    @user = user
    mail(to: @user.email,
      subject: 'Goalivate Weekly Summary',
      from: 'jack@goalivate.com')
    content_type "text/html"
  end

end
