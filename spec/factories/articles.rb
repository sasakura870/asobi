FactoryBot.define do
  factory :article do
    title { "MyString" }
    overview { "MyString" }
    content { "MyText" }
    posted { false }
    thumbnail { "MyString" }
    user_id { "" }
  end
end
