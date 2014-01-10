FactoryGirl.define do
  factory :goal do
    exercise
    user

    starting_max '20'
    target_max '50'
    end_date (Date.today + 30)
  end
end
