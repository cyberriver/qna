FactoryBot.define do
  sequence(:title) {|n| "Question #{n}"} 
  
  factory :question do
    title   
    body { "MyText" }    
    author { association :user }
    best_answer_id {nil}

    trait :invalid_data do
      title {nil}
    end


  end
end
