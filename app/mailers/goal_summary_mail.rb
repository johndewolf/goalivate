class GoalSummaryMail < ActionMailer::Base

  def send_summary(user_id)
    @user = User.find(user_id)
    mail to: @user.email,
      subject: 'Goalivate Weekly Summary',
      from: 'jack@goalivate.com'
  end

end
