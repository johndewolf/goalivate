class GoalSummaryWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  def perform(user_id)
    user = User.find(user_id)
    GoalSummaryMailer.send_summary(user).deliver
  end
end
