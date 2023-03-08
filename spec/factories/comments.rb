FactoryBot.define do
  factory :comment do
    sequence :title do |n|
      "Comment title #{n}"
    end
  end

  trait :invalid do
    title { nil }
  end
end
