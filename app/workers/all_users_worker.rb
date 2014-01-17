class AllUsersWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  # recurrence do
  #   weekly(1).day_of_week(5).hour_of_day(15)
  # end

  def perform
    User.pluck(:id).each do |user_id|
      GoalSummaryWorker.perform_async(user_id)
    end
  end
end
