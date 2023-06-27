FactoryBot.define do
  factory :comment do
    sequence(:title) {|n| "Comment title #{n}" }
    author { association :user }

  trait :invalid do
    title { nil }
  end
end
end
