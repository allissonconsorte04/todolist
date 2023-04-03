FactoryBot.define do
  factory :log_activity do
    activity { nil }
    event { "MyString" }
    modifications { "MyText" }
  end
end
