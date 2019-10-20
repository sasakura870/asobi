FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "textTitle#{n}" }
    overview { 'testOverview' }
    content { Faker::Lorem.sentence(word_count: 10) }
    status { :published }

    trait :draft do
      status { :draft }
    end
  end
end
