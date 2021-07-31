FactoryBot.define do
  factory :user do #factory :testuser, class: User do のようにクラスを明示すればモデル名以外のデータも作れます。
    name { "test" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { "testuser" }
    password_confirmation { "testuser" }
  end
end
