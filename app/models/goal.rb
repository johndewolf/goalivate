class Goal < ActiveRecord::Base
  after_create :create_first_checkpoint
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

  def create_first_checkpoint
    weekly_increase = ((target_max - starting_max.to_f) / days_in_goal) * 7
    Checkpoint.create(target: starting_max + weekly_increase, goal: self, complete_by: Date.today + 7)
  end

  def end_date_has_passed?
    Date.today > end_date
  end

  def goal_met?
    checkpoints.last.user_input == target_max
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
      else
        weeks
      end
  end
end

