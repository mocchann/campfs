FactoryBot.define do
  factory :review do
    association :field
    association :user
    title { "最高のキャンプ場" }
    content { "癒やしの空間に包まれる！" }
    rate { 5.0 }
    user_id { user.id }
    field_id { field.id }
  end
end
