FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }

    trait :with_credits_40_to_60 do
      after(:create) do |user|
        create(:credit, user: user, amount: rand(40..60))
      end
    end

    trait :with_credits_above_60 do
      after(:create) do |user|
        create(:credit, user: user, amount: rand(61..100))
      end
    end
  end
end
