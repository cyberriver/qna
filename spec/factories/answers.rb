FactoryBot.define do
  factory :answer do
    sequence(:title) { |n| "Answer #{n}" }
    question

    trait :invalid_data do
      title {nil}
    end
    
  end
end
