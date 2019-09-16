FactoryBot.define do
  factory :user do
    name { 'TestUser' }
    email { 'test@sample.com' }
    introduction { 'MyText' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :user_faker, class: User do
    sequence(:name) { |n| "faker-#{n}" }
    sequence(:email) { |n| "fake#{n}@example.com"}
    # name { 'fake' }
    # email { 'fake@example.com' }
    introduction { Faker::Lorem.sentence(word_count: 5) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
