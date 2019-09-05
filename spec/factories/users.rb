FactoryBot.define do
  factory :user do
    name { 'TestUser' }
    email { 'test@sample.com' }
    introduction { 'MyText' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :user_faker, class: User do
    name { 'fake' }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.sentence(5) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
