class GoalSummaryMail < ActionMailer::Base

  def send_summary(user)

    mail to: user.email,
      subject: 'Goalivate Weekly Summary',
      content: 'Here is your weekly summary',
      from: 'jack@goalivate.com'
  end

end
