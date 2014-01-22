class GoalSummaryWorker
  include Sidekiq::Worker
    sidekiq_options :retry => false

  def perform(user_id)
    user = User.find(user_id)
    GoalSummaryMailer.send_summary(user).deliver
  end
end
