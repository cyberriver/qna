FactoryBot.define do
  factory :question do
    sequence(:title) {|n| "Question #{n}"}    
    body { "MyText" }
    test

    trait :invalid_data do
      title {nil}
    end
  end
end
