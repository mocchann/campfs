FactoryBot.define do
  factory :review do
    title { "MyString" }
    content { "MyText" }
    rate { 1.5 }
    user { nil }
    field { nil }
  end
end
