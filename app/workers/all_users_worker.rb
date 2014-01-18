class AllUsersWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

    sidekiq_options :retry => false

  recurrence { weekly }

  def perform
    User.pluck(:id).each do |user_id|
      GoalSummaryWorker.perform_async(user_id)
    end
  end
end
