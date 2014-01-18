class GoalSummaryWorker
  include Sidekiq::Worker
    sidekiq_options :retry => false

  def perform(user_id)
    GoalSummaryMail.send_summary(user_id).deliver
  end
end
