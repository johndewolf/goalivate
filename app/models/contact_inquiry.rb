class ContactInquiry < ActiveRecord::Base
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :email, length: { maximum: 25 }, presence: true
  validates_presence_of :subject
  validates_presence_of :content

end
