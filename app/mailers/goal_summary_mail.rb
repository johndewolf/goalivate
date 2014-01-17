class GoalSummaryMail < ActionMailer::Base

  def send_summary(user_id)
    user = User.find(user_id)
    mail to: user.email,
      subject: 'Goalivate Weekly Summary',
      from: 'jack@goalivate.com'
    # if user.goals.active == nil
    #   user_with_no_active_goals(user)
    # else
    #   users_with_active_goals(user)
    # end
  end

  # def users_with_active_goals(user)
  #   mail to: user.email,
  #     subject: 'Goalivate Weekly Summary',
  #     from: 'jack@goalivate.com'
  # end

  # def users_with_no_active_goals(user)
  #   mail to: user.email,
  #     subject: 'Get your life in order and create a goal!',
  #     from: 'jack@goalivate.com'
  # end

end
