FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "textTitle#{n}" }
    overview { 'testOverview' }
    content { Faker::Lorem.sentence(word_count: 10) }
    posted { true }
    thumbnail { nil }

    trait :draft do
      posted { false }
    end
  end
end
