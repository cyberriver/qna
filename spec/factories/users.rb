FactoryBot.define do
  sequence(:email) { |n| "user#{n}@test.com" }

  factory :user do
    email { generate(:email) }
    password { 'qwerty' }
    password_confirmation { 'qwerty' }
  end
end
