class AllUsersWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    weekly.day(:sunday)
  end

  def perform
    User.pluck(:id).each do |user_id|
      GoalSummaryWorker.perform_async(user_id)
    end
  end
end
