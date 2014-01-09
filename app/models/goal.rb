class Goal < ActiveRecord::Base
  after_create :create_checkpoints
  validates_presence_of :exercise
  validates_presence_of :starting_max
  validates_presence_of :target_max
  validates_presence_of :end_date
  validate :date_is_in_the_future,
    if: -> (goal) { goal.end_date.present? }
  validate :goal_is_greater_than_start,
    if: -> (goal) { goal.target_max.present? && goal.starting_max.present? }
  belongs_to :user,
  inverse_of: :goals

  belongs_to :exercise,
  inverse_of: :goals

  has_many :checkpoints,
  inverse_of: :goal,
  dependent: :destroy

  def create_checkpoints
    weekly_increase = ((target_max - starting_max.to_f) / days_in_goal) * 7
    weeks_in_goal.times do |num|
      Checkpoint.create(target: starting_max + (weekly_increase * num), goal: self)
    end
      last = checkpoints.last
      last.target = target_max
      last.save
  end

  private

  def goal_is_greater_than_start
    unless target_max > starting_max
      errors[:target_max] << 'Goal max must be greater than starting '
    end
  end

  def date_is_in_the_future
    unless end_date > Date.today + 7
      errors[:end_date] << "must be 7 days in the future"
    end
  end

  def days_in_goal
    (end_date - created_at) / (24 * 60 * 60)
  end

  def weeks_in_goal
    weeks = days_in_goal / 7
      if weeks % 1 != 0
        (weeks + 1).to_i
      else weeks
      end
  end

  # def make_target(target)
  #   increase_percent = (target.to_f - starting_max) / target
  #   rep_increase = target_max * increase_percent
  #   binding.pry
  #   (starting_max + rep_increase / weeks_in_goal).ceil
  # end
end

