FactoryBot.define do
  factory :article do
    title { "testTitle" }
    overview { "testOverview" }
    content { Faker::Lorem.sentence(10) }
    posted { false }
    thumbnail { "" }
    user_id { "" }
  end
end
