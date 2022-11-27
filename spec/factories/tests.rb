FactoryBot.define do
  factory :test do
    sequence(:title) {|n| "Question #{n}"}    
    string { "MyString" }
    level { 1 }
  end
end
