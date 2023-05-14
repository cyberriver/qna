FactoryBot.define do
  factory :comment do
    sequence(:title) {|n| "Comment title #{n}" } 

  trait :invalid do
    title { nil }
  end
end
end
