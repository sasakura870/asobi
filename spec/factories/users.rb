FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "faker-#{n}" }
    sequence(:email) { |n| "fake#{n}@example.com" }
    nick_name { 'nick_name' }
    introduction { Faker::Lorem.sentence(word_count: 5) }
    password { 'password' }
    password_confirmation { 'password' }
    activated { true }

    trait :temporary do
      activated { false }
    end

    trait :with_articles do
      transient do
        post_count { 5 }
        draft_count { 0 }
      end

      after(:create) do |user, evaluator|
        evaluator.post_count.times do
          user.articles.create(attributes_for(:article))
        end
        evaluator.draft_count.times do
          user.articles.create(attributes_for(:article, :draft))
        end
      end
    end
  end
end
