FactoryBot.define do
  factory :bookmark do
    association :user
    association :field
  end
end
