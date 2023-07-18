FactoryBot.define do
  factory :credit do
    amount { rand(40..60) }

    association :user
  end
end