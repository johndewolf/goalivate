class GoalSummaryWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly(1) }

  def perform
    # user = User.find(1)
    GoalSummaryMailer.send_summary(1).deliver
  end
end
