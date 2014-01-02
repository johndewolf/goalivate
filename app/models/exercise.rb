class Exercise < ActiveRecord::Base
  validates_presence_of :name

  has_many :goals,
    inverse_of: :exercise
end
