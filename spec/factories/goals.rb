FactoryGirl.define do
  factory :goal do
    user
    title 'freethrows'
    unit_of_measurement 'shots'
    starting_point '20'
    target '50'
    end_date (Date.today + 30)
  end
end
