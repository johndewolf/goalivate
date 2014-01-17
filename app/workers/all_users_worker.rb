class AllUsersWorker
  include Sidekiq::Worker

  def perform
    User.pluck(:id).each do |user_id|
      GoalSummaryWorker.perform_async(user_id)
    end
  end


end
