class AllUsersWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

    sidekiq_options :retry => false

  recurrence do
    weekly(1).day_of_week(6).hour_of_day(17)
  end

  def perform
    User.pluck(:id).each do |user_id|
      GoalSummaryWorker.perform_async(user_id)
    end
  end
end
