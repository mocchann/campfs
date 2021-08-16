FactoryBot.define do
  factory :contact do
    name { "testuser" }
    message { "testtext" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
  end
end
