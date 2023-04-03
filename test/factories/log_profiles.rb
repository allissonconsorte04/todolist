FactoryBot.define do
  factory :log_profile do
    user { nil }
    event { "MyString" }
    changes { "MyText" }
  end
end
