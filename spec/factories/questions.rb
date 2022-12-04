FactoryBot.define do
  factory :question do
    sequence(:title) {|n| "Question #{n}"}    
    body { "MyText" }
    

    trait :invalid_data do
      title {nil}
    end
  end
end
