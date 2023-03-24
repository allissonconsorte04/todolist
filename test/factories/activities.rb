FactoryBot.define do
  factory :activity do
    code { "MyString" }
    title { "MyString" }
    description { "MyText" }
    category { "MyString" }
    status { nil }
    public { false }
  end
end
