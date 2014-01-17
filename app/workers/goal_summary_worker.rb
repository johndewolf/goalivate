class GoalSummaryWorker
  include Sidekiq::Worker

  def perform(user_id)
    GoalSummaryMail.send_summary(user_id).deliver
  end
end
