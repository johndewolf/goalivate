class GoalSummaryWorker
  include Sidekiq::Worker
    sidekiq_options :retry => false

  def perform(user_id)
    user = User.find(user_id)
    GoalSummaryMail.send_summary(user).deliver
  end
end
#2014-01-18T21:22:02Z 882 TID-ouzckdveg WARN: undefined method `[]=' for nil:NilClass
#2014-01-18T21:22:02Z 882 TID-ouzckdveg WARN: /Users/johndewolf/Dropbox/launchacademy/work/delta/breakable_toy_two/app/mailers/goal_summary_mail.rb:8:in `send_summary'
