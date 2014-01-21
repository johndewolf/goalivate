class GoalSummaryMail < ActionMailer::Base

  def send_summary(user)

    mail to: user.email,
      subject: 'Goalivate Weekly Summary',
      from: 'jack@goalivate.com'
  end

end
