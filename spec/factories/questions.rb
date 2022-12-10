FactoryBot.define do
  sequence(:title) {|n| "Question #{n}"} 
  
  factory :question do
    title   
    body { "MyText" }    
    author { association :user }

    trait :invalid_data do
      title {nil}
    end

  end
end
