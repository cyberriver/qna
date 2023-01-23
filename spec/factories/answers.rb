FactoryBot.define do
  factory :answer do
    sequence(:title) { |n| "Answer #{n}" }
    question { association :question }
    author { association :user }

    trait :invalid_data do
      title {nil}
    end
    
  end
end
