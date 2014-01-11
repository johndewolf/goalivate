FactoryGirl.define do
  factory :checkpoint do
    goal
    target 50
    complete_by Date.today + 1.week

    trait :completed do
      user_input 20
    end

    factory :completed_checkpoint, traits: [:completed]
  end
end
