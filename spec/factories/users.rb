FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@aol.com" }
    first_name 'jack'
    last_name 'd'
    password 'applepie'
    password_confirmation 'applepie'
  end
end
