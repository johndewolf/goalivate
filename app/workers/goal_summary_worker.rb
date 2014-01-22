class GoalSummaryWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

   recurrence do
    daily.hour_of_day(18.5)
   end

  def perform
    user = User.find(1)
    GoalSummaryMailer.send_summary(user).deliver
  end
end
