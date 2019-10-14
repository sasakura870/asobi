FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "faker_#{n}" }
    sequence(:email) { |n| "fake#{n}@example.com" }
    nick_name { 'nick_name' }
    introduction { Faker::Lorem.sentence(word_count: 5) }
    password { 'password' }
    password_confirmation { 'password' }
    status { :register }

    trait :admin do
      status { :admin }
    end

    trait :temporary do
      status { :temporary }
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
