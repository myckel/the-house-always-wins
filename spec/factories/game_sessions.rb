FactoryBot.define do
  factory :game_session do
    association :user
    credits { 100 }

    trait :with_credits_40_to_60 do
      credits { 40 + rand(21) }
    end

    trait :with_credits_above_60 do
      credits { 61 + rand(40) }
    end
  end
end
