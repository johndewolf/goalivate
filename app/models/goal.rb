class Goal < ActiveRecord::Base
  # after_create :create_first_checkpoint
  before_save :singularize_measurement_unit

  validates :starting_point, numericality: { greater_than_or_equal_to: 0 }
  validates_presence_of :target
  validates_presence_of :end_date
  validates_presence_of :title
  validates_presence_of :unit_of_measurement
  validate :date_is_in_the_future,
    if: -> (goal) { goal.end_date.present? }
  validate :goal_is_greater_than_start,
    if: -> (goal) { goal.target.present? && goal.starting_point.present? }

  belongs_to :user,
    inverse_of: :goals

  has_many :checkpoints,
    inverse_of: :goal,
    dependent: :destroy

  def end_date_has_passed?
    Date.today > end_date
  end

  def remaining_units
    if checkpoints.completed.any?
      target - checkpoints.last.user_input
    else
      target
    end
  end

  def days_remaining
    (end_date.to_date - Date.today).to_i
  end

  def delete_invalid_checkpoints
    checkpoints.each do |checkpoint|
      if checkpoint.user_input == nil
        checkpoint.delete
      end
    end
  end

  def days_in_goal
    ((end_date - created_at) / (60 * 60 * 24)).to_i
  end

  def self.active
    incomplete.where("end_date >= ?", Date.today)
  end

  def self.past
    where("end_date <= ? OR completed_on IS NOT null", Date.today)
  end

  def self.incomplete
    where(completed_on: nil)
  end

  def self.completed
    where("completed_on IS NOT null")
  end

  def percentage_complete
    if last_user_input == nil
      0
    else
      100 - ((((target - last_user_input) / target).abs) * 100)
    end
  end

  def last_user_input
    last = checkpoints.where("user_input IS NOT null").order(:updated_at).last
    if last == nil
      nil
    else
      last.user_input
    end
  end

  private

  def goal_is_greater_than_start
    unless target > starting_point
      errors[:target] << 'Goal max must be greater than starting'
    end
  end

  def date_is_in_the_future
    unless end_date > Date.today + 7
      errors[:end_date] << "must be 7 days in the future"
    end
  end

  def singularize_measurement_unit
    unit_of_measurement.singularize
  end

  # def weeks_in_goal
  #   weeks = days_in_goal / 7
  #     if weeks % 1 != 0
  #       (weeks + 1).to_i
  #     else
  #       weeks
  #     end
  # end
end

