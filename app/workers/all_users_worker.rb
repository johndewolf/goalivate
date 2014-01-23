class AllUsersWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  weekly.day(:monday).hour_of_day(8)

  def perform
    User.pluck(:id).each do |user_id|
      GoalSummaryWorker.perform_async(user_id)
    end
  end
end
