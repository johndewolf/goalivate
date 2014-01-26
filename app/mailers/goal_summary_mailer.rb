class GoalSummaryMailer < ActionMailer::Base

  def send_summary(user)
    @user = user
    mail(to: @user.email,
      subject: 'Goalivate Weekly Summary',
      from: 'Jack@goalivate.com')
  end

end
