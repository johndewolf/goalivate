# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact_inquiry do
    first_name 'Jack'
    last_name 'D'
    email 'jackd@aol.com'
    subject 'test'
    content 'test111'
  end
end
