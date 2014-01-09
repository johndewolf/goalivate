FactoryGirl.define do
  factory :goal do
    starting_max '20'
    target_max '30'
    end_date (Date.today + 30)

    exercise
    user
  end
end
